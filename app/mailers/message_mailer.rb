class MessageMailer < ActionMailer::Base
  default :from => "me@iamneato.com"

  def create_message_email(message)
    @message = message

    mail(:to => to,
         :subject => "#{message.user.username} added a new #{message.type_name.downcase} on Famlog")
  end

  def update_message_email(message)
    @message = message

    mail(:to => to,
         :subject => "#{message.user.username} updated an existing #{message.type_name.downcase} on Famlog")
  end

  private

  def to
    # ['ejcavazos@gmail.com']
    ['jmorris22734@gmail.com', 'ejcavazos@gmail.com']
  end
end
