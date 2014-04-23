class SitePagesController < ApplicationController
  def about
    @users = User.order("RANDOM()").limit(4)
  end

  def contact
  end
  
  # Public: Search action for user names.
  #
  # params[:name_query] - Search string sent from form on _largenav partial
  #
  # Calls User class method to search for name in query string sent from search 
  # form.  If no users are found, returns to users index view (root view), 
  # otherwise users are rendered on a search_results page.
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
