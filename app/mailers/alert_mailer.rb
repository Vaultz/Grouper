class AlertMailer < ApplicationMailer
  default from: 'grouperlpdw@gmail.com'

    def send_mail(mailAddresses)
      mail(to: "paulvialart@hotmail.fr", subject: 'Test mail')
    end

end
