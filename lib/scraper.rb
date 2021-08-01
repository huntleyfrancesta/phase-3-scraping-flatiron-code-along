require 'nokogiri'
require 'open-uri'
require 'pry'

require_relative './course.rb'

class Scraper
  
  def print_courses
    self.make_courses
    Course.all.each do |course|
      if course.title && course.title != ""
        puts "Title: #{course.title}"
        puts "  Schedule: #{course.schedule}"
        puts "  Description: #{course.description}"
      end
    end
  end

  def get_page
    Nokogiri::HTML(open("http://learn-co-curriculum.github.io/site-for-scraping/courses")) 
    binding.pry
  end

  Scraper.new.get_page

  def get_courses
    self.get_page.css(".post")
  end

  def make_courses
    get_courses.each do |post|
      course = course.new 
      course.title = post.css("h2").text 
      course.schedule = post.css("date").text
      course.description = post.css("p").text
      binding.pry
      course.image = post.css("img").first[:src]
      #add this ^^^ one to course.rb attr_accessor
      #image as an array so need .first ^^^
    end
  end

      

  
end
