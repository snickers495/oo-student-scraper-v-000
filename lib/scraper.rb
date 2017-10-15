require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    array = []
    html = File.read(index_url)
    new_html = Nokogiri::HTML(html)
    new_html.css("div.student-card").each do |profile|
      hash = {
        name: profile.css("a div.card-text-container h4").text,
        location: profile.css("a div.card-text-container p").text,
        profile_url: profile.css("a").attribute("href").text }
      array << hash
    end
    array
  end

  def self.scrape_profile_page(profile_url)
    html = File.read(profile_url)
    new_html = Nokogiri::HTML(html)
    profile = {}
    links = new_html.css('div.vitals-container div.social-icon-container a')
    links.each do |link|
      if link.css("a").attr("href").value.include?("twitter")
        profile[:twitter] = links.css("a").attr("href").text
      elsif link.css("a").attr("href").value.include?("linkedin")
        profile[:linked] = links.css("a").attr("href").text
      end


  end
# twitter url, linkedin url, github url, blog url, profile quote, and bio
# bio: (div.details-container div.bio-block details-block div.bio-content div.description-holder p )
# profile: div.vitals-container div.vitals-text-container div.profile-quote
# twitter url: div.vitals-container div.social-icon-container a

end
