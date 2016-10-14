class CreateWorkshopController < ApplicationController
  include Wicked::Wizard
  # define the different step the form will have, wicked will automatiquely go to the next when validating

  steps :create, :validate
  # the main action for wicked, every step go through here
  def show
    #@workshop.user_id = current_user.id # Give the current user id at the new workshop
    case step
    when :create
      # @workshop will be use to make the corresponding form in the view
      @workshop = Workshop.new
      #initialize the session variable that will be use to store the datas before saving to the database
      session[:workshop] = nil
    when :validate
      @workshop = Workshop.new(session[:workshop])



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
      # we create a new variable session with the nexly acquired info on the workshop
      #then we redirect to the next step defore wicked can save to the database
    @workshop = Workshop.new(workshop_params)
    @workshop.user_id = current_user.id # Give the current user id at the new workshop
    session[:workshop] = @workshop.attributes
    #We look at the generation mode
    if @workshop.teamgeneration == 0
      #Let's create a variable for the groups
      @groups = Array.new
      #The time will be use to get only the users of the same year
      time = Time.now
      year = time.to_s(:school_year)
      #if we have to choose projects leader we query the database differently
      if @workshop.projectleaders
        #Leaders had register with the status equal to 1
        leaders = User.where('year = ? AND status=1', year).shuffle
        users = User.where('year = ? AND status=0', year).shuffle
      else
        #everyone is a slave ... to whom ?
        users = User.where('year = ?', year).shuffle
      end
      #Let's look at the nomber of projects we have to generate
      @workshop.teamnumber.times do |i|
        #projects are instanciate

        #We take advantage of the loop to generate the right nomber of groups
        @groups[i] = Array.new
      end
      #This is where the magic append
      #we call the method with the leaders
      @groups = distribute_users(@groups, leaders)
      #then we call it with the users
      @groups = distribute_users(@groups, users)


    end

    redirect_to next_wizard_path
    #When validating the last form the step won't be 'validate' but something else, so we put else
    else
      @workshop = Workshop.new(session[:workshop])
      if @workshop.save
          #When saving project to database
          #@projects[i]= @workshop.projects.create(name: @workshop.name + '_##{i}', description: 'Add a more precise description', created_at: time, updated_at: time)
          redirect_to workshops_path(), notice: "Workshop was successfully created"
      end
    end
  end
  private

  def finish_wizard_path
   workshops_path()
  end
  # Never trust parameters from the scary internet, only allow the white list through.
  def workshop_params
    params.require(:workshop).permit(:name, :description, :user_id, :teacher, :begins, :ends, :teamgeneration, :teamnumber, :projectleaders)
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
      distribute_users(groups,users)
    end
    @groups = groups
  end

end
