require 'open-uri'
class Scraper
  def initialize()
    
  end
  
  def scrape_events()
    
    page = Nokogiri::HTML(open("http://www.siliconprairienews.com/events")) 
    
    page.css(".vevent").each do |e|
      event = Event.new
      
      #event.title = 
      puts e.css("td.event-name a")
      
    end
  end
end