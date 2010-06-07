class Notifier < ActionMailer::Base
  default :from => 'tool@famlog.heroku.com'

  Host = "http://famlog.heroku.com"

  def create_message_email(message)
    template(message, 'added a new')
  end

  def update_message_email(message)
    desc = message.is_event? ? 'updated an' : 'updated a'
    template(message, desc)
  end

  def message_reply_email(reply)
    @reply = reply
    @url   = new_message_reply_url(@reply.message, :host => Host)

    mail(:to => to, :subject => "#{reply.user.username} replied on Famlog")
  end

  private

  def template(message, description)
    @message = message
    @url = Host

    mail(:to => to,
         :subject => "#{message.user.username} #{description} #{message.type_name.downcase} on Famlog")
  end

  def to
    return 'ejcavazos@gmail.com' if Rails.env == 'development'
    ['jmorris22734@gmail.com', 'ejcavazos@gmail.com']
  end
end
