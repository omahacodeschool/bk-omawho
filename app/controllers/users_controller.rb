class UsersController < ApplicationController
  # GET /users
  # GET /users.json
  def index

    # If category_id parameter present and 
    # and it respresents a valid non-zero category id, 
    # filter users by that category
    if params[:category_id].present? && 
       params[:category_id].to_i > 0 &&
       params[:category_id].to_i <= Category.count 
      
      # Find filtered users by Category.users
      @filter_category = Category.find(params[:category_id])
      @users = @filter_category.users.random.limit(12)
      
    # Otherwise just choose randomly (Filter for "all" categories)
    else
      @filter_category = nil
      @users = User.random.limit(12)
    end
     
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find_by_username(params[:username])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new
    @image = Image.new
    @categories = Category.all()

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
    @image = Image.find(@user.profile_image_id)
    @categories = Category.all()
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])
    @image =  Image.find(params[:user][:profile_image_id])
    @user.images << @image 

    respond_to do |format|
      if @user.save
        auto_login(@user)
        format.html { redirect_to view_profile_path(@user.username), notice: 'User was successfully created.' }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])
    @image = Image.find(@user.profile_image_id)
    @categories = Category.all()
    
    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to view_profile_path(@user.username), notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end
  
  def responsivetemplate
  end
end
