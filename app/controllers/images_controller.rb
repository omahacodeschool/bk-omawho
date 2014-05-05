class ImagesController < ApplicationController
  skip_before_filter :require_login, :except => [:edit, :update, :destroy]
  
  # GET /images
  def index
    @images = Image.all

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /images/:id
  def show
    @image = Image.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  # GET /images/new
  def new
    @image = Image.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /images/:id/edit
  def edit
    @image = Image.find(params[:id])
  end

  # POST /images
  def create

    @image = Image.new(params[:image])
    
    respond_to do |format|
      if @image.save
        format.html { redirect_to view_profile_path(current_user.username), notice: 'Image was successfully created.' }
        format.js
      else
        format.html { render action: "new" }
        format.js
      end
    end
  end

  # PUT /images/:id
  def update
    @image = Image.find(params[:id])

    respond_to do |format|
      if @image.update_attributes(params[:image])
        format.html { redirect_to @image, notice: 'Image was successfully updated.' }
        format.js
      else
        format.html { render action: "edit" }
        format.js
      end
    end
  end

  # DELETE /images/:id
  def destroy
    @image = Image.find(params[:id])
    @image.destroy

    respond_to do |format|
      format.html { redirect_to view_profile_path(current_user.username), notice: 'Image was successfully deleted.' }
    end
  end
end
