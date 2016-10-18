class AlertMailer < ApplicationMailer
default from: 'paulvialart@gmail.com'

    def send_mail(mailAddresses)

      mail(to: "paulvialart@hotmail.fr", subject: 'Test mail')
      mailAddresses.each do |address|

      end
    end

end
