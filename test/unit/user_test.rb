require 'test_helper'

class UserTest < ActiveSupport::TestCase
  setup do
    @user = User.create(:username => 'blah', :first_name => 'blah', :last_name => 'blah', :email => 'blah@blah.com')
  end

  should "should get user's family members" do
    user2 = User.create(:username => 'blah1', :first_name => 'blah', :last_name => 'blah')
    user3 = User.create(:username => 'blah2', :first_name => 'blah', :last_name => 'blah')

    assert_equal 2, User.family_members(@user).count
  end

  context 'owns?' do
    should 'return true when user is assigned to entity' do
      message = Message.new(:user => @user)

      assert @user.owns?(message)
    end

    should 'return false when user is not assigned to entity' do
      message = Message.new

      assert !@user.owns?(message)
    end

    should 'return false when object does not respond to user' do
      assert !@user.owns?(Object.new)
    end
  end
end
