class UserMailer < ActionMailer::Base
  default from: "vitalikVVV@gmail.com"

  def ticket_notification(user, ticket)
    @user = user
    @ticket = ticket
    mail( :to => "#{user.name} <#{user.email}>",
          :subject => "Ticket Notificarion: Status Changed"
    )
          #:body => "Status of your posted  ticket is changed"
  end
end
