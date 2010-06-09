module RepliesHelper
  def destroy_reply_link(message, reply)
    return unless current_user.owns?(reply)
    link_to "Delete", message_reply_path(message, reply), :method => :delete
  end
end
