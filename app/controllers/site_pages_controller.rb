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

  # Public: Start the name game.
  #
  # Renders name_game quiz with random user.
  def name_game
    @user = User.order('RANDOM()').first
    @companies = User.pluck(:company).uniq.select {|co| co != @user.company }
    @companies = @companies.shuffle[0..2]
    @companies << @user.company
    @companies.shuffle!
    @profile_img = @user.profile_image ? @user.profile_image : "user-avatar.jpg"
  end
  
  def check_quiz
    @user = User.find(params[:user_id])
    if (params[:name_guess] == "")
      @guessed_name = "<no guess>"
    else
      @guessed_name = params[:name_guess]
    end
    @guessed_co = params[:company]
    @name_guess_correct = (@guessed_name.upcase == @user.full_name.upcase)
    @co_guess_correct = (@guessed_co == @user.company)   
    @profile_img = @user.profile_image ? @user.profile_image : "user-avatar.jpg"
  end
  
end
