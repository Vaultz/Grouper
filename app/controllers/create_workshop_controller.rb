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
        @workshop.user_id = current_user.id
      else
        @workshop = Workshop.new(workshop_params)
        @workshop.user_id = current_user.id
     end

      #Add redirection
      respond_to do |format|
        if @workshop.save
          session[:workshop_unfinished] = Workshop.last.id
          format.html { redirect_to next_wizard_path, notice: 'Workshop was successfully updated.' }
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


    if @workshop.teamgeneration == 0
      #Let's create a variable for the groups
      @@groups = Array.new
      #The time will be use to get only the users of the same year
      time = Time.now
      year = time.to_s(:school_year)
      #if we have to choose projects leader we query the database differently
      if @workshop.projectleaders == 1
        #Leaders had register with the status equal to 1
        leaders = User.where('year = ? AND status=1', year).shuffle
        users = User.where('year = ? AND status=0', year).shuffle
      else
        #everyone is a slave ... to whom ?
        users = User.where('year = ? AND status=0 OR status=1', year).shuffle
      end
      #Let's look at the nomber of projects we have to generate
      @workshop.teamnumber.times do |i|
        #projects are instanciate

        #We take advantage of the loop to generate the right nomber of groups
        @@groups[i] = Array.new
      end
      #This is where the magic append
      #we call the method with the leaders
      if @workshop.projectleaders == 1
        @@groups = distribute_users(@@groups, leaders)
      end

      #then we call it with the users
      @@groups = distribute_users(@@groups, users)
      projects = @workshop.projects.limit(@workshop.teamnumber).shuffle
      projects.each_with_index do |project, index|
          projects[index].users << @@groups[index]
      end

    end

    if @workshop.teamgeneration == 1
      session.delete(:workshop_unfinished)
      return redirect_to workshops_path
    end

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
  def distribute_users(groups,users)
    # n°1 we look how many at the minimum it will have in a group
    # n°2 The number will be 0 or 1
    nb = (users.size/@workshop.teamnumber).round
    # n°1 in case it is 0 we put it at 1
    # n°2 This is when it can be usefull
    nb = nb == 0 ? 1 : nb
    # n°1 we iterate for each group, taking the minimum
    # It will put one of the remaining and adding it to one group, then to an other
    groups.each_with_index do |group, index|
      nb.times do |i|
        if users.any?
          #shift remove from users array and we append it to the group
          groups[index] << users.shift
        end
      end

    end
    if users.any?
      #if there is still users without group we call the method again
      groups = groups.reverse
      distribute_users(groups,users)
    end
    @@groups = groups
  end

end
