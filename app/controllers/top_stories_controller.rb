class TopStoriesController < ApplicationController

  @@first=0
  @@last=29

  def index
    @top_response = HTTParty.get("https://hacker-news.firebaseio.com/v0/topstories.json")

    @top_stories_array=[]
    @top_stories_stored=[]
    # total_sections = (@top_response.length-1)/30

    display_array_setup(@@first,@@last)
    stored_array_setup(@@first,@@last)

    respond_to do |format|
      format.html do
        if request.xhr?
            @top_stories_array.clear
            @top_stories_array = @top_stories_stored.clone
            @top_stories_stored.clear
            render partial: 'stories'
            @@first+=60
            @@last+=60
            stored_array_setup(@@first,@@last)
        end
      end
      format.json {render json: @top_stories_stored}
    end

  end

  def display_array_setup(first,last)
    i=first
    n=last

    (i..n).each do
      single_response = HTTParty.get("https://hacker-news.firebaseio.com/v0/item/#{@top_response[i]}.json")

      single_story_hash = {}
      single_story_hash[:id] = single_response["id"]
      single_story_hash[:title] = single_response["title"]
      single_story_hash[:author] = single_response["by"]
      single_story_hash[:url] = single_response["url"]
      single_story_hash[:comments_num] = single_response["descendants"]
      single_story_hash[:score] = single_response["score"]
      single_story_hash[:time] = single_response["time"]
      @top_stories_array.push(single_story_hash)

      i+=1
    end
  end

  def stored_array_setup(first,last)
    i=first+30
    n=last+30

    (i..n).each do
      single_response = HTTParty.get("https://hacker-news.firebaseio.com/v0/item/#{@top_response[i]}.json")

      single_story_hash = {}
      single_story_hash[:id] = single_response["id"]
      single_story_hash[:title] = single_response["title"]
      single_story_hash[:author] = single_response["by"]
      single_story_hash[:url] = single_response["url"]
      single_story_hash[:comments_num] = single_response["descendants"]
      single_story_hash[:score] = single_response["score"]
      single_story_hash[:time] = single_response["time"]
      @top_stories_stored.push(single_story_hash)

      i+=1
    end
  end
end
