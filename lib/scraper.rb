require 'nokogiri'
require 'open-uri'
require_relative './course.rb'
require 'pry'

class Scraper
  def print_courses
    self.make_courses
    Course.all.each do |course|
      if course.title
        puts "Title: #{course.title}"
        puts "  Schedule: #{course.schedule}"
        puts "  Description: #{course.description}"
      end
    end
  end

  def get_page
    html = open("http://learn-co-curriculum.github.io/site-for-scraping/courses")
    doc = Nokogiri::HTML(html)
  end

  def get_courses
    doc = get_page
    return doc.css("article.post")
  end

  def make_courses
    doc = get_courses
    doc.each do |element|
      course = Course.new
      course.title = element.css("h2").text
      course.schedule = element.css("em.date").text
      course.description = element.css("p").text
    end
  end
end
