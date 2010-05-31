class MessageMailer < ActionMailer::Base
  default :from => 'me@iamneato.com'

  def create_message_email(message)
    template(message, 'added a new')
  end

  def update_message_email(message)
    desc = message.is_event? ? 'updated an' : 'updated a'
    template(message, desc)
  end

  private

  def template(message, description)
    @message = message

    mail(:to => to,
         :subject => "#{message.user.username} #{description} #{message.type_name.downcase} on Famlog")
  end

  def to
    return 'ejcavazos@gmail.com' if Rails.env == 'development'
    ['jmorris22734@gmail.com', 'ejcavazos@gmail.com']
  end
end
