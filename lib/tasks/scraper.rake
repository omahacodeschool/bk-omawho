namespace :scrape do
  desc "Scrapes all configured webpages for events"
  task :all => [:spn]
  desc "Scrapes SiliconPrairieNews.com for events"
  task :spn => :environment do
    Scraper.scrape_spn
  end
end