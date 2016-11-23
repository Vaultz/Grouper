class CreateWorkshopController < ApplicationController
  include Wicked::Wizard
  # define the different step the form will have, wicked will automatiquely go to the next when validating

  steps :create, :projectsname, :validate
  # the main action for wicked, every step go through here
  def show
    #@workshop.user_id = current_user.id # Give the current user id at the new workshop
    case step
    when :create
      if session[:workshop_unfinished]
       @workshop = Workshop.find(session[:workshop_unfinished])
      else
        # @workshop will be use to make the corresponding form in the view
        @workshop = Workshop.new
     end
    when :projectsname
      if session[:workshop_unfinished]
        @workshop = Workshop.find(session[:workshop_unfinished])
      end
      projects = []
      if @workshop.projects.any?
        @workshop.projects.each do |project|
          project.destroy
        end
      else
       @workshop.teamnumber.times do |i|
         projects << @workshop.projects.build
       end
     end

      #@workshop = Workshop.new(session[:workshop])
    when :validate

      if session[:workshop_unfinished]
        @workshop = Workshop.find(session[:workshop_unfinished])
      end
      @datas = []
      projects = @workshop.projects.limit(@workshop.teamnumber)
      projects.each_with_index do |project, index|
          @datas[index] = {}
          @datas[index]['project'] = project
          @datas[index]['users'] = project.users
      end
    end

    # render the view corresponding to the actual step
    render_wizard
  end
# each step of the wizard will go through the update action before showing the next step
  def update
    #@workshop = Workshop.new(workshop_params)
    #@workshop.user_id = current_user.id # Give the current user id at the new workshop
    #render_wizard @workshop
    case step
    when :create
      if session[:workshop_unfinished]
        @workshop = Workshop.find(session[:workshop_unfinished])
        @workshop.update(workshop_params)

      else
        @workshop = Workshop.new(workshop_params)
      end
      @workshop.user_id = current_user.id
      time = Time.now
      year = time.to_s(:school_year)
      @workshop.year = year
      #Add redirection
      respond_to do |format|
        if @workshop.save
          session[:workshop_unfinished] = Workshop.last.id
          format.html { redirect_to next_wizard_path, notice: I18n.t('views.workshop.flash_messages.workshop_was_successfully_created') }
        else
          format.html { render wizard_path }
          #format.json { render json: @workshop.errors, status: :unprocessable_entity }
        end
    end

    when :projectsname
      # we create a new variable session with the nexly acquired info on the workshop
      #then we redirect to the next step defore wicked can save to the database
    @workshop = Workshop.find(session[:workshop_unfinished])
    #@workshop.user_id = current_user.id # Give the current user id at the new workshop
    #session[:workshop] = @workshop.attributes
    #We look at the generation mode
    projects = []
    error = false
    project_params[:projects_attributes].each_pair do |key,project_tmp|
      project = @workshop.projects.new(project_tmp)
      projects << project
      unless project.valid?
        error = true
      end
    end
    if error
      render wizard_path
      return
    else
      projects.each do |project|
        project.save
      end
    end



    #######################
    ### TEAM GENERATION ###
    #######################

    # Full random mode
    if @workshop.teamgeneration == 0 || @workshop.teamgeneration == 2
      #Let's create a variable for the groups
      @@groups = Array.new
      #if we have to choose projects leader we query the database differently
      if @workshop.projectleaders == 1
        #Leaders had register with the status equal to 1
        #Let's order them according to the number of time they were project leader
        leaders = User.joins(:works).select('users.*, COUNT(works.project_leader) as leader_count').where('status = 1 AND year = ?', @promo).order('leader_count DESC').group('users.id').to_a
        users = User.where('year = ? AND status=0', @promo).to_a
        difference = @workshop.teamnumber - leaders.size
        if difference > 0
          leaders.concat(users.slice!(0,difference))
        elsif difference < 0
          #if leaders have to be put aside it will be the ones who have been project leader the most
          users.concat(leaders.slice!(0,(difference.abs)))
        end
      else

        #everyone is a slave ... to whom ?
        users = User.where('year = ? AND status=0 OR status=1', @promo)
      end

      if @workshop.teamgeneration == 2
        #grouping them after the suffle do the trick
        #and it take care of every gender
        users = users.group_by{|x| x.gender}.values
      else
        users = users.group_by{|x| true}.values
      end

      #Let's look at the nomber of projects we have to generate
      @workshop.teamnumber.times do |i|
        #projects are instanciate
        #We take advantage of the loop to generate the right nomber of groups
        @@groups[i] = Array.new
      end
      projects = @workshop.projects.limit(@workshop.teamnumber).shuffle
      #This is where the magic append
      #we call the method with the leaders
      if @workshop.projectleaders == 1

        @@groups = distribute_users(@@groups, leaders)
        #abort @@groups.inspect
        projects.each_with_index do |project, index|
            projects[index].users << @@groups[index].shift
            project.works.last.update_attribute :project_leader, 1
            @@groups[index] = []
        end
      end
      #then we call it with the users
      users.each_with_index do |usergroup, index|
        distribute_users(@@groups, usergroup.shuffle)
      end

      projects.each_with_index do |project, index|
          projects[index].users << @@groups[index]
          pick_attendees(projects, project)
      end




    end

    # MANUAL MODE
    if @workshop.teamgeneration == 1
      redirect_to finish_wizard_path
      return
    end

    # MIXED MODE
    # Similar to the full random mode, but females are splitted before males
=begin
    if @workshop.teamgeneration == 2
      @@groups = Array.new
      time = Time.new
      year = time.to_s(:school_year)

      if @workshop.projectleaders == 1
        leaders = User.where('year = ? AND status = 1', year).shuffle
        females = User.where('year = ? AND status = 0 AND gender = "f"', year).shuffle
        males = User.where('year = ? AND status = 0 AND gender = "m"', year).shuffle
      else
        females = User.where('year = ? AND gender = "f"', year).shuffle
        males = User.where('year = ? AND gender = "m"', year).shuffle
      end

      @workshop.teamnumber.times do |i|
        @@groups[i] = Array.new
      end
      projects = @workshop.projects.limit(@workshop.teamnumber).shuffle

      if @workshop.projectleaders == 1
        @@groups = distribute_users(@@groups, leaders, false)
        projects.each_with_index do |project, index|
            projects[index].users << @@groups[index].shift
            project.works.last.project_leader = 1
            @@groups[index] = nil
        end

      end

      @@groups = distribute_users(@@groups, females)
      @@groups = distribute_users(@@groups, males)

      projects.each_with_index do |project, index|
          projects[index].users << @@groups[index]
      end

    end
=end

    redirect_to next_wizard_path
    #When validating the last form the step won't be 'validate' but something else, so we put else
    # else
    #   @workshop = Workshop.new(session[:workshop])
    #   if @workshop.save
    #       #When saving project to database
    #       projects[i]= @workshop.projects.create(project_params)
    #       redirect_to workshops_path(), notice: "Workshop was successfully created"
    #   end
    end
  end

  private

  def finish_wizard_path
    session.delete(:workshop_unfinished)
    workshops_path()
  end
  # Never trust parameters from the scary internet, only allow the white list through.
  def workshop_params

    params.require(:workshop).permit(:name, :description, :user_id, :teacher, :begins, :ends, :teamgeneration, :teamnumber, :projectleaders)
  end
  def project_params
    params.require(:workshop).permit(projects_attributes: [:name,:description])
  end

  # We use a recursive method, because we have to distribuate: projects leaders and users in 2 times
  def distribute_users(groups, users)
    # n°1 we look how many at the minimum it will have in a group
    # n°2 The number will be 0 or 1
    nb = (users.size/@workshop.teamnumber).round
    # n°1 in case it is 0 we put it at 1
    # n°2 This is when it can be usefull
    nb = nb == 0 ? 1 : nb
    # n°1 we iterate for each group, taking the minimum
    # It will put one of the remaining and adding it to one group, then to an other
    groups.sort_by!(&:length)

    groups.each_with_index do |group, index|
      if users.any?
          #shift remove from users array and we append it to the group
          groups[index].concat(users.slice!(0,nb))
      else
        break
      end
    end
    #we reverse groups to fill those which have less users in priority in the next call of distribute_users
    if users.any?
      #if there is still users without group we call the method again
      distribute_users(groups,users)
    end
    @@groups = groups
  end


  def pick_attendees(projects, project)
    user = project.users.joins(:orals).select('users.*, COUNT(orals.user_id) as been_attendees').order('been_attendees').group('users.id').first;
    other_projects = projects.reject { |x| x.id == project.id }
    other_projects.each do |project|
      project.attendees << user
    end
    #users.inspect
  end

end
