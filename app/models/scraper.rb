require 'open-uri'
class Scraper
  def initialize()
    
  end
  
  def self.scrape_spn()
    
    page = Nokogiri::HTML(open("http://www.siliconprairienews.com/events")) 
    
    #each section containing an event
    page.css(".vevent").each do |e|
      event = Event.new
      
      #event.name
      #puts e.css("td.event-name a")[0].text
      event.name = e.css("td.event-name a")[0].text
      #event.description
      
      #event.start_time
      #puts e.css("td.event-date span.dtstart span.value-title")[0]["title"]
      if e.css("td.event-date span.dtstart span.value-title")[0]
        event.start_time = e.css("td.event-date span.dtstart span.value-title")[0]["title"]
      end
      
      #event.end_time
      #puts e.css("td.event-date span.dtstart span.dtend span.value-title")[0]["title"]
      if e.css("td.event-date span.dtend span.value-title")[0]
        event.end_time = e.css("td.event-date span.dtend span.value-title")[0]["title"]
      end
      
      #event.venue
      if e.css("td.location.vcard").text.strip == "TBA"
        #puts e.css("td.location.vcard").text.strip
        event.venue = "TBA"
        event.location = "TBA"
      else
        #puts e.css("td.location.vcard").text.strip.split("\n")[0]
        event.venue = e.css("td.location.vcard").text.strip.split("\n")[0]
        #event.location
        l = e.css("td.location.vcard span.fn.org span span.adr span.locality").text
        l += e.css("td.location.vcard span.fn.org span span.adr span.region").text
        event.location = l
      end
      
      #event.link
      #puts e.css("td.event-name a")[0]["href"]
      event.link = e.css("td.event-name a")[0]["href"]
      event.approved = true
      event.save
    end
  end
end