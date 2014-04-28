class SitePagesController < ApplicationController
  skip_before_filter :require_login
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
  # Renders name_game quiz with random user. Companies are picked
  
  def name_game
    @user = User.order('RANDOM()').first
    @companies = User.pluck(:company).uniq.select {|co| co != @user.company }
    @companies = @companies.compact.shuffle[0..2]
    @companies << @user.company
    @companies.shuffle!
    @profile_img = @user.profile_image ? @user.profile_image : "user-avatar.jpg"
  end
  
  def check_quiz
    # Get user from param id
    @user = User.find(params[:user_id])
    @social_media = [["facebook", @user.facebook], ["twitter", @user.twitter], ["pinterest", @user.pinterest], ["dribbble", @user.dribbble], ["linkedin", @user.linkedin], ["github", @user.github], ["googleplus", @user.googleplus], ["instagram", @user.instagram]]
    
    @social_media.each do |social|
      if social[1] != ""
        @user_has_social_media = true
        return
      end
    end
    
    # Check name guess for existence and/or match to actual name
    if (!params[:name_guess] || params[:name_guess] == "")
      @guessed_name = "You didn't even guess. What's the deal?"
      @name_guess_correct = false
    else
      @guessed_name = params[:name_guess]
      @name_guess_correct = (@guessed_name.upcase == @user.full_name.upcase)
    end
    
    # Check user company for existence and set instance variable for matching
    if @user.company
      @correct_co = @user.company
    else
      @correct_co = nil
    end

    # Check company guess for existence and/or match to actual company
    if (!params[:company])
      @guessed_co = nil
      @co_guess_correct = false
    else
      @guessed_co = params[:company]
      # If no user company, compare the guess to "No Company Specified"
      if ((!@correct_co) && (@guessed_co == "No Company Specified"))
        @co_guess_correct = true
      # Otherwise compare the guess to the user's company
      else
        @co_guess_correct = (@guessed_co == @correct_co)  
      end 
    end

    @profile_img = @user.profile_image ? @user.profile_image : "user-avatar.jpg"
  end
  
end
