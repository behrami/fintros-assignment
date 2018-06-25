class TopStoriesController < ApplicationController
  def index
    story_response = HTTParty.get("https://hacker-news.firebaseio.com/v0/topstories.json")
    # NewStory.start_value_stored = NewStory.start_value+30
    # NewStory.end_value_stored = NewStory.end_value+30

    top_stories_display_section = story_response[TopStory.start_value..TopStory.end_value]
    top_stories_stored_section = story_response[TopStory.start_value_stored..TopStory.end_value_stored]

    if TopStory.start_value == 0 && TopStory.start_value_stored == 30
      TopStory.stories_display = TopStory.stories_array_calc(top_stories_display_section)
      TopStory.stories_stored = TopStory.stories_array_calc(top_stories_stored_section)
    end

    TopStory.start_value_stored+=30
    if TopStory.end_value_stored+30 < story_response.length-1
      TopStory.end_value_stored+=30
    else
      TopStory.end_value_stored = story_response.length-1
    end

    respond_to do |format|
      format.html do
        if request.xhr?
          TopStory.stories_display.clear
          TopStory.stories_display = TopStory.stories_stored.clone
          TopStory.stories_stored.clear
          TopStory.stories_stored = TopStory.stories_array_calc(top_stories_stored_section)
          render partial: 'stories'
        end
      end
    end

  end

end
