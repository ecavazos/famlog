require 'test_helper'

class RepliesHelperTest < ActionView::TestCase

  context 'destroy link' do
    setup do
      @user = User.create(:username => 'master shifu')
      stubs(:current_user).returns(@user)
    end

    should 'create a destroy link for a reply' do
      reply = Reply.create(:user => @user)
      expected = "<a href=\"/reply/#{reply.id}\" data-method=\"delete\" rel=\"nofollow\">Delete</a>"
      assert_equal expected, destroy_link(reply)
      assert false
    end

    should 'do nothing when reply does not belong to current user' do
      reply = Reply.create(:user => User.new)
      assert_nil destroy_link(reply)
    end
  end
end
