class AlertsController < ApplicationController
  def index
  end

  # get and put user emails in the @mails var, depending on what year it is
  def create

    time = Time.now
    year = time.to_s(:school_year)
    users = User.where('year = ?', year)
    mailAddresses = Array.new

    users.each do |user|
      mailAddresses << user.email
    end

    # when calling the Rails Mail object, you need to call the deliver_now method in order to send the mail right now
    mailreturn = AlertMailer.send_mail(mailAddresses).deliver_now

  end

end
