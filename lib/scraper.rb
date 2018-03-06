require 'open-uri'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    page = Nokogiri::HTML(open index_url)
    page.css("div[class='student-card']").collect do |card|
     {
       :name => card.css("a div h4").text.gsub('\n',''),
       :location => card.css("a div p").text.gsub('\n',''),
       :profile_url => card.css("a")[0]['href'] 
      } 
    end
  end

  def self.scrape_profile_page(profile_url)
    page = Nokogiri::HTML(open profile_url)
    output = Hash.new
    output[:bio] = page.css('div.bio-content p').text
    output[:profile_quote] = page.css('div.profile-quote').text
    page.css('div.social-icon-container a').collect do |anchor|
      anchor.collect do |url|
        address = url[1]
        if address.include? 'twitter'
            output[:twitter] = address
          elsif address.include? 'linkedin'
            output[:linkedin] = address
          elsif address.include? 'github.com'
            output[:github] = address
          else 
            output[:blog] = address
        end
      end
    end
    output
  end
end

