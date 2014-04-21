class Event < ActiveRecord::Base
  attr_accessible :cancelled, :description, :end_time, :link, :location, :name, :start_time, :venue
end
