class UsersController < ApplicationController

  skip_before_filter :require_login, :except => [:edit, :update, :destroy, :editgallery]

  # GET /users
  def index
    
    # Setting limit of 100 users passed in to view.  The view should further
    # limit showing users (e.g., diplay them in groups of 12)
    users_limit = 100
    
    # If category_id parameter is present and 
    # and it respresents a valid non-zero category id, 
    # filter users by that category.
    # (Note: the .to_i method converts a string to 0)
    if params[:category_id].present? && 
       params[:category_id].to_i > 0 &&
       params[:category_id].to_i <= Category.count 
      
      # Get random list of users for the selected category
      @filter_category = Category.find(params[:category_id])
      @users = @filter_category.users.random.limit(users_limit)
      
      if @users.length == 0
        flash.now.alert = "No users in #{@filter_category.name} found."
        @filter_category = nil
        @users = User.random.limit(users_limit)
        #Rails.cache.fetch("users") { User.random.limit(users_limit)} 
      end
      
    # Otherwise just choose randomly (Filter for "all" categories)
    else
      @filter_category = nil
      @users = User.random.limit(users_limit)
      
    end
     
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  # GET /users/:id
  # GET /:username
  def show
    @image = Image.new
    if params[:id]
      @user = User.find(params[:id])
    elsif params[:username]
      @user = User.where("username ILIKE ?", params[:username]).first
    end
    puts @user
    if !@user
      
      flash.now.alert = "User not found"
      redirect_to :root
    else
      respond_to do |format|
        format.html # show.html.erb
      end
    end
  end

  # GET /users/new
  def new
    @user = User.new
    @image = Image.new
    @categories = Category.cached_all()

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
    @image = Image.find(@user.profile_image_id)
    @categories = Category.cached_all()
    if current_user.admin?
      #do nothing, proceed to edit page
    elsif @user != current_user
      flash.now.alert = "You must be logged in as this user."
      redirect_to :root
    end
  end
  
  # GET /users/1/editgallery
  def editgallery
    @user = User.find(current_user.id)
    @image = Image.new
  end

  # POST /users
  def create
    @user = User.new(params[:user])
    @image =  Image.find(params[:user][:profile_image_id])
    #@user.images << @image 
    @categories = Category.cached_all()

    respond_to do |format|
      if @user.save
        auto_login(@user)
        format.html { redirect_to view_profile_path(@user.username), notice: 'User was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  # PUT /users/1
  def update
    @user = User.find(params[:id])
    @image = Image.find(@user.profile_image_id)
    @categories = Category.cached_all()
    
    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to view_profile_path(@user.username), notice: 'User was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  # DELETE /users/1
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
    end
  end
  
  # GET /responsivetemplate
  # for showing how to use it
  def responsivetemplate
  end
end
