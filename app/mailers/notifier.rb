class Notifier < ActionMailer::Base

  Host = Famlog::Settings.mail.host
  Url = "http://#{Host}"

  default :from => "tool@#{Host}"

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
    @url = Url

    mail(:to => to,
         :subject => "#{message.user.username} #{description} #{message.type_name.downcase} on Famlog")
  end

  def to
    return Famlog::Settings.mail.admin_email if Rails.env == 'development'
    User.all.map { |x| x.email }
  end
end
