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
=begin
    if @workshop.teamgeneration == 0
      groups = Array.new
      time = Time.now
      year = time.to_s(:school_year)
      users = User.where('year = #{year}').shuffle

      @workshop.teamnumber.times do |i|
        @projects[i]= @workshop.projects.create(name: @workshop.name + '_##{i}', description: 'Add a more precise description', created_at: time, updated_at: time)
        groups[i] = Array.new
      end
      groups, users = randomize_groups(groups, users)
=end
    end
    redirect_to next_wizard_path
    #When validating the last form the step won't be 'validate' but something else, so we put else
    else
      @workshop = Workshop.new(session[:workshop])
      if @workshop.save
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
    params.require(:workshop).permit(:name, :description, :user_id, :teacher, :begins, :ends, :teamgeneration, :teamnumber)
  end

  def randomize_groups (groups, users)
    groups.each do |group|

    end


    if users.any?
      groups, users = ramdomize_groups (groups, users)
    end
    return groups, users
  end

end
