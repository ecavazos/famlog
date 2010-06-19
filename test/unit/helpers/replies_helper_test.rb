require 'test_helper'

class RepliesHelperTest < ActionView::TestCase

  context 'destroy reply link' do
    setup do
      @message = Factory.create(:message)
      @user = User.create(:username => 'master shifu')
      stubs(:current_user).returns(@user)
    end

    should 'create a destroy link for a reply' do
      reply = @message.replies.create(:text => 'blah', :user => @user)
      expected = "<a href=\"/messages/#{@message.id}/replies/#{reply.id}\" data-method=\"delete\" rel=\"nofollow\">Delete</a>"
      assert_equal expected, destroy_reply_link(@message, reply)
    end

    should 'do nothing when reply does not belong to current user' do
      reply = @message.replies.build(:text => 'blah', :user => User.new)
      assert_nil destroy_reply_link(@message, reply)
    end
  end
end
