class CreateWorkshopController < ApplicationController
  include Wicked::Wizard

  steps :create, :validate

  def show

    @workshop = Workshop.new()
    @workshop.user_id = current_user.id # Give the current user id at the new workshop
    @workshop.name = "TestinController"
    case step
    when :create
      @workshop = Workshop.new
    when :validate
    end
    
    render_wizard
  end


  def update
    @workshop = Workshop.new()
    @workshop.name = "TestinController"
  end
  # Never trust parameters from the scary internet, only allow the white list through.
  def workshop_params
    params.require(:workshop).permit(:name, :description, :user_id, :teacher, :begins, :ends, :teamgeneration, :teamnumber)
  end

end
