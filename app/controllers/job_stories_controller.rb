class JobStoriesController < ApplicationController

  def index
    job_response = HTTParty.get("https://hacker-news.firebaseio.com/v0/jobstories.json")

    @job_stories_array=[]
    i=0
    job_response.each do
      single_response = HTTParty.get("https://hacker-news.firebaseio.com/v0/item/#{job_response[i]}.json")

      single_story_hash = {}
      single_story_hash[:title] = single_response["title"]
      single_story_hash[:author] = single_response["by"]
      single_story_hash[:url] = single_response["url"]
      single_story_hash[:comments_num] = single_response["descendants"]
      single_story_hash[:score] = single_response["score"]

      seconds_diff = (Time.now - Time.at(single_response["time"])).to_i.abs
      hours = seconds_diff / 3600
      seconds_diff -= hours * 3600
      minutes = seconds_diff / 60
      seconds_diff -= minutes * 60
      seconds = seconds_diff

      if hours !=0
        single_story_hash[:time] = "#{hours} hours ago"
      elsif minutes !=0
        single_story_hash[:time] = "#{minutes} minutes ago"
      else
        single_story_hash[:time] = "#{seconds} seconds ago"
      end

      @job_stories_array.push(single_story_hash)
      i+=1
    end
  end
end
