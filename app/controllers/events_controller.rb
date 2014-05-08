class EventsController < ApplicationController
  skip_before_filter :require_login, :except => [:new, :edit, :update, :destroy]
  
  # GET /events/
  def index
    if current_user && current_user.admin?
      @unapproved = Event.where('approved = ?', false).order('start_time ASC')
      @events = Event.approved.where('start_time > ?', DateTime.now).order("start_time ASC")
      @past_events = Event.approved.where('start_time < ?', DateTime.now).order("start_time DESC").page(params[:page]).per(5)
    else
      @events = Event.approved.where('start_time > ?', DateTime.now).order("start_time ASC")
      @past_events = Event.approved.where('start_time < ?', DateTime.now).order("start_time DESC").page(params[:page]).per(5)
    end
    
    if current_user
      @user_events = current_user.events
    end
  end

  # GET /events/:id
  def show
    @event = Event.find(params[:id])
    @users = @event.users
  end
  
  # GET /events/new
  def new
    @event = Event.new
  end

  # GET /events/:id/edit
  def edit    
    if current_user && current_user.admin?
      @event = Event.find(params[:id])
    else
      not_authenticated
    end
  end
  
  # POST /events
  def create
    @event = Event.new(params[:event])
    if current_user
      current_user.events << @event
    end

    respond_to do |format|
      if @event.save
        format.html { redirect_to :events, notice: 'Request to add event received.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  # PUT /events/:id
  def update
    if current_user && current_user.admin?
      @event = Event.find(params[:id])

      respond_to do |format|
        if @event.update_attributes(params[:event])
          format.html { redirect_to event_path(@event), notice: 'Event was successfully updated.' }
        else
          format.html { render action: "edit" }
        end
      end
    else
      not_authenticated
    end
  end
  
  # DELETE /events/:id
  def destroy
    if current_user && current_user.admin?
      @event = Event.find(params[:id])
      @event.destroy
      
      respond_to do |format|
        format.html { redirect_to events_url }
      end
    else
      not_authenticated
    end
  end
  
  # POST /events/:event_id/attend
  def attend
    @event = Event.find(params[:event_id])
    
    if current_user.events.exists?(@event)
      current_user.events.delete(@event)
    else
      current_user.events << @event
    end
    
    @user_events = current_user.events
    
    respond_to do |format|
      format.html { redirect_to event_path(@event) }
      format.js
    end
  end
  
  # GET /past
  def past
    @past_events = Event.approved.where('end_time < ?', DateTime.now).order("end_time DESC").page(params[:page]).per_page(5)
    
    respond_to do |format|
      format.html
      format.js
    end
  end
  
  # POST /events/:event_id/approve
  def approve
    if current_user && current_user.admin?
      @event = Event.find(params[:event_id])
  
      respond_to do |format|
        if @event.update_attribute(:approved, true)
          format.html { redirect_to :events, notice: 'Event approved.' }
        else
          format.html { redirect_to :events, alert: 'Error.' }
        end
      end
    else
      not_authenticated
    end
  end
end
