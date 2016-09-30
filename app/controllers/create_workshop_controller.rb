class CreateWorkshopController < ApplicationController
  include Wicked::Wizard

  steps :create, :validate

  def show

=begin    @workshop = Workshop.new(workshop_params)
    @workshop.user_id = current_user.id # Give the current user id at the new workshop
=end
    case step
    when :create
      @workshop = Workshop.new
    when :validate

    end
    render_wizard
  end

end
