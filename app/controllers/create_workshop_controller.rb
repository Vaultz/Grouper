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
      .
      #initialize the session variable that will be use to store the datas before saving to the database
      session[:workshop] = nil
    when :validate

      #@workshop = Workshop.new(session[:workshop])
    #  @project = Project.new
    end
    # render the view corresponding to the actual step
    render_wizard
  end

# each step of the wizard will go through the update action before showing the next step
  def update

=begin
    @workshop = Workshop.new(workshop_params)
    @workshop.user_id = current_user.id # Give the current user id at the new workshop
    render_wizard @workshop
=end
    case step
    when :create
      # we create a new variable session with the nexly acquired info on the workshop
      #then we redirect to the next step defore wicked can save to the database
    #  @workshop = Workshop.new(workshop_params)
    #  @workshop.user_id = current_user.id # Give the current user id at the new workshop
    #  session[:workshop] = @workshop.attributes
    #  redirect_to next_wizard_path
    when :validate
=begin        @workshop = Workshop.new(session[:workshop])
    if @workshop.save
        redirect_to workshops_path(), notice: "Thank you for signing up."
      end
      #redirect_to_finish_wizard
    end
=end
  end
=begin
  def finish_wizard_path
   workshops_path()
  end
=end
  # Never trust parameters from the scary internet, only allow the white list through.
  def workshop_params
    params.require(:workshop).permit(:name, :description, :user_id, :teacher, :begins, :ends, :teamgeneration, :teamnumber)
  end

end
