class TopStory < ApplicationRecord
    @start_value = 0
    @end_value = 29
    @start_value_stored = @start_value+30
    @end_value_stored = @end_value+30
    @stories_display=[]
    @stories_stored=[]

  def self.start_value
    @start_value
  end

  def self.end_value
    @end_value
  end

  def self.start_value_stored
    @start_value_stored
  end

  def self.end_value_stored
    @end_value_stored
  end

  def self.stories_display
    @stories_display
  end

  def self.stories_stored
    @stories_stored
  end

  def self.start_value_stored=(value)
    @start_value_stored=value
  end

  def self.end_value_stored=(value)
    @end_value_stored=value
  end

  def self.stories_display=(value)
    @stories_display=value
  end

  def self.stories_stored=(value)
    @stories_stored=value
  end

  def self.stories_array_calc(stories)
    i=0
    stories_array=[]
    stories.each do
      single_response = HTTParty.get("https://hacker-news.firebaseio.com/v0/item/#{stories[i]}.json")

      @single_story_hash = {}
      @single_story_hash[:response_id] = single_response["id"]
      @single_story_hash[:title] = single_response["title"]
      @single_story_hash[:author] = single_response["by"]
      @single_story_hash[:url] = single_response["url"]
      @single_story_hash[:comments_num] = single_response["descendants"]
      @single_story_hash[:score] = single_response["score"]

      time_calculation(single_response)

      stories_array.push(@single_story_hash)

      i+=1
    end
    return stories_array

  end

  def self.time_calculation(single_response)
    seconds_diff = (Time.now - Time.at(single_response["time"])).to_i.abs
    hours = seconds_diff / 3600
    seconds_diff -= hours * 3600
    minutes = seconds_diff / 60
    seconds_diff -= minutes * 60
    seconds = seconds_diff

    if hours !=0
      @single_story_hash[:time] = "#{hours} hours ago"
      return @single_story_hash[:time]
    elsif minutes !=0
      @single_story_hash[:time] = "#{minutes} minutes ago"
      return @single_story_hash[:time]
    else
      @single_story_hash[:time] = "#{seconds} seconds ago"
      return @single_story_hash[:time]
    end

  end

end
