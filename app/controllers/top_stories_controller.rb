class TopStoriesController < ApplicationController
  def index
    top_response = HTTParty.get("https://hacker-news.firebaseio.com/v0/topstories.json")

    top_stories_display_section = top_response[TopStory.start_value..TopStory.end_value]
    top_stories_stored_section = top_response[TopStory.start_value_stored..TopStory.end_value_stored]

    if TopStory.start_value == 0 && TopStory.start_value_stored == 30
      TopStory.stories_display = TopStory.top_stories_array_calc(top_stories_display_section)
      TopStory.stories_stored = TopStory.top_stories_array_calc(top_stories_stored_section)
    end

    TopStory.start_value_stored+=30
    TopStory.end_value_stored+=30

    respond_to do |format|
      format.html do
        if request.xhr?
          TopStory.stories_display.clear
          TopStory.stories_display = TopStory.stories_stored.clone
          TopStory.stories_stored.clear
          TopStory.stories_stored = TopStory.top_stories_array_calc(top_stories_stored_section)
          render partial: 'stories'
        end
      end
    end

  end

end
