class FamiliesController < ApplicationController
  layout 'no_tabs'

  def show
    @family = current_user.family
  end
end
