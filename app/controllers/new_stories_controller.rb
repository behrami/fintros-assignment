class NewStoriesController < ApplicationController

  def index
    new_response = HTTParty.get("https://hacker-news.firebaseio.com/v0/newstories.json")
    new_body = JSON.parse(new_response.body)

    @new_stories_array=[]
    i=0
    30.times do #restrict to 30 for now
      single_response = HTTParty.get("https://hacker-news.firebaseio.com/v0/item/#{new_body[i]}.json")

      single_story_hash = {}
      single_story_hash[:title] = single_response["title"]
      single_story_hash[:author] = single_response["by"]
      single_story_hash[:url] = single_response["url"]
      single_story_hash[:comments_num] = single_response["descendants"]
      single_story_hash[:score] = single_response["score"]
      single_story_hash[:time] = single_response["time"]
      @new_stories_array.push(single_story_hash)
      i+=1
    end
  end
end
