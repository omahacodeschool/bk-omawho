class SitePagesController < ApplicationController
  def about
  end

  def contact
  end
  
  def search
    @query = params[:name_query]
    @users_found = User.all  # create/call User.search_name(@query) method
    
    if @users_found.nil?
      @users = User.all
      flash.now[:alert] = "No users matching '#{@query}' were found"
      render "users/index"
    else
      render "search_results"
    end
  end
  
end
