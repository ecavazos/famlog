class MessageMailer < ActionMailer::Base
  default :from => "me@iamneato.com"

  def new_message_email(message)
    @message = message

    mail(:to => ['jmorris22734@gmail.com', 'ejcavazos@gmail.com'], :subject => 'Famlog Updated')
  end
end
