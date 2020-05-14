# require libraries/modules here
require 'nokogiri'
require 'pry'


def create_project_hash
  # This file will open and store it into a variable called html
  html = File.read("fixtures/kickstarter.html")
  kickstarter = Nokogiri::HTML(html)
  # projects: kickstarter.css("li.project.grid_4")
# title: project.css("h2.bbcard_name strong a").text
#image link: project.css("div.project-thumbnail a img").attribute("src").value
#description: project.css("p.bbcard_blurb").text
# percent funded: project.css("ul.project-stats li.first.funded strong").text.gsub("%","").to_i

projects = {} #<-here we create an empty hash as it will contain the scraped elements that will be stored in the projects hash/ variable

kickstarter.css("li.project.grid_4").each do |project|
  title = project.css("h2.bbcard_name strong a").text

  projects[title.to_sym] = {:image_link => project.css("div.project-thumbnail a img").attribute("src").value,
  :description => project.css("p.bbcard_blurb").text, :location => project.css("ul.project-meta span.location-name").text,
:percent_funded => project.css("ul.project-stats li.first.funded strong").text.gsub("%","").to_i}
# projects is a hash that has the title being converted here as a symbol. The keys in the hash are the title type of projects
#such as images, descriptions, locations and percent_funded and the value is displayed here as a key using the specific html/css selectors.
end

projects #<- We have to call the projects hash from above to return the scraping elements
  #binding.pry
  # write your code here
end

create_project_hash
