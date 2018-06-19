class AskStoriesController < ApplicationController

  def index
    ask_response = HTTParty.get("https://hacker-news.firebaseio.com/v0/askstories.json")

    @ask_stories_array=[]
    i=0
    30.times do #restrict to 30 for now
      single_response = HTTParty.get("https://hacker-news.firebaseio.com/v0/item/#{ask_response[i]}.json")

      single_story_hash = {}
      single_story_hash[:title] = single_response["title"]
      single_story_hash[:author] = single_response["by"]
      single_story_hash[:url] = single_response["url"] #needs changing
      single_story_hash[:comments_num] = single_response["descendants"]
      single_story_hash[:score] = single_response["score"]
      single_story_hash[:time] = single_response["time"]
      @ask_stories_array.push(single_story_hash)
      i+=1
    end
  end
end
