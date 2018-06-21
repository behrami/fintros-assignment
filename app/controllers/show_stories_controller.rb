class ShowStoriesController < ApplicationController

  @@first=0
  @@last=29
  @@first_stored=30
  @@last_stored=59

  def index
    @show_response = HTTParty.get("https://hacker-news.firebaseio.com/v0/showstories.json")

    @show_stories_array=[]
    @show_stories_stored=[]

    display_array_setup(@@first,@@last)
    stored_array_setup(@@first_stored,@@last_stored)

    respond_to do |format|
      format.html do
        if request.xhr?
            @show_stories_array.clear
            @show_stories_array = @show_stories_stored.clone
            @show_stories_stored.clear
            render partial: 'stories'
            @@first_stored+=30
            if @@last_stored+30 < @show_response.length-1
              @@last_stored+=30
            else
              @@last_stored=@show_response.length-1
            end
            stored_array_setup(@@first_stored,@@last_stored)
        end
      end
      format.json {render json: @show_stories_stored}
    end

  end

  def display_array_setup(first,last)
    i=first
    n=last

    (i..n).each do
      single_response = HTTParty.get("https://hacker-news.firebaseio.com/v0/item/#{@show_response[i]}.json")

      single_story_hash = {}
      single_story_hash[:id] = single_response["id"]
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

      @show_stories_array.push(single_story_hash)

      i+=1
    end
  end

  def stored_array_setup(first,last)
    i=first
    n=last

    (i..35).each do #NEEDS A FIX
      single_response = HTTParty.get("https://hacker-news.firebaseio.com/v0/item/#{@show_response[i]}.json")

      single_story_hash = {}
      single_story_hash[:id] = single_response["id"]
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

      @show_stories_stored.push(single_story_hash)

      i+=1
    end
  end
end
