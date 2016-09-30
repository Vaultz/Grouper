class CreateWorkshopController < ApplicationController
  include Wicked::Wizard

  steps :create, :validate

  def show


    #@workshop.user_id = current_user.id # Give the current user id at the new workshop

    case step
    when :create
      @workshop = Workshop.new
      session[:workshop] = nil
    when :validate

=begin
      @workshop = Workshop.last
      @params = params
=end
      @workshop = Workshop.new(session[:workshop])
    end

    render_wizard
  end


  def update

=begin
    @workshop = Workshop.new(workshop_params)
    @workshop.user_id = current_user.id # Give the current user id at the new workshop
    render_wizard @workshop
=end
    case step
    when :create
      @workshop = Workshop.new(workshop_params)
      @workshop.user_id = current_user.id # Give the current user id at the new workshop
      session[:workshop] = @workshop.attributes
      redirect_to next_wizard_path
    when :validate
      @workshop = Workshop.new(session[:workshop])
      @workshop.save
      #redirect_to workshop_path(@workshop)
    end
  end

  def finish_wizard_path
   workshops_path()
  end
  # Never trust parameters from the scary internet, only allow the white list through.
  def workshop_params
    params.require(:workshop).permit(:name, :description, :user_id, :teacher, :begins, :ends, :teamgeneration, :teamnumber)
  end

end
