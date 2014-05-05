class SitePagesController < ApplicationController
  skip_before_filter :require_login
  def about
    @users = User.random.limit(4)
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
      @users = User.random.limit(12)
      flash.now[:alert] = "No users matching '#{@query}' were found"
      render "users/index"
    else
      render "search_results"
    end
  end

  # Public: Start the name game.
  #
  # Renders name_game quiz with random user. Companies are picked
  
  def name_game
    @user = User.random.first
    if @user.nil? 
      flash.now[:alert] = "No users in the database!"
      redirect_to root_path
    end
    user_co = @user.company ? @user.company : ""
    @companies = User.pluck(:company).uniq.select {|co| co != user_co }
    @companies = @companies.compact.shuffle[0..2]
    @companies << user_co
    @companies.shuffle!
    @profile_img = @user.profile_image ? @user.profile_image : "user-avatar.jpg"
  end
  
  def check_quiz
    # Get user from param id
    @user = User.find(params[:user_id])
    
    # Check name guess for no guess or a match and clean up extra spaces
    if params[:name_guess].blank?
      @guessed_name = "No Name Guess"
      @name_guess_correct = false
    else
      @guessed_name = params[:name_guess].strip
      @name_guess_correct = @user.name_matches?(@guessed_name)
    end

    # Check company guess and match. No clean up needed for multiple choice.
    if params[:company].blank?
      @guessed_co = "No Company Guess"
      @co_guess_correct = false
    else
      @guessed_co = params[:company]
      @co_guess_correct = @user.company_matches?(@guessed_co)
    end

    @profile_img = @user.profile_image ? @user.profile_image : "user-avatar.jpg"
  end
  
end
