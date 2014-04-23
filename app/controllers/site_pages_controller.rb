class SitePagesController < ApplicationController
  def about
    @users = User.order("RANDOM()").limit(4)
  end

  def contact
  end
end
