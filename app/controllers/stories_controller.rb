class StoriesController < ApplicationController

  def index
    if current_user
      @area = current_user.area
      @stories = Story.where(:area => @area)
    end
  end

  def new
    @story = Story.new
  end

  def create
    @story = Story.new(story_params)
    @story.area = current_user.area
    @story.save
    redirect_to '/stories'
  end

  private

  def story_params
   params.require(:story).permit(:headline, :details)
 end

end
