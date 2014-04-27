require 'spec_helper'

describe Scraper do
  
  it "can scrape Silicon Praire News events" do
    Event.delete_all
    Scraper.scrape_spn
    expect(Event.count).to be > 0
  end
  
end
