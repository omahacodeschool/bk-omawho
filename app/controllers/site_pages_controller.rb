class SitePagesController < ApplicationController
  def about
    @users = User.order("RANDOM()").limit(4)
  end

  def contact
  end
  
  def search
    @query = params[:name_query]
    @users_found = User.search_name(@query)  # User class method
    
    if @users_found.nil? || @users_found.count < 1
      @users = User.order("RANDOM()").limit(12)
      flash.now[:alert] = "No users matching '#{@query}' were found"
      render "users/index"
    else
      render "search_results"
    end
  end
  
end
