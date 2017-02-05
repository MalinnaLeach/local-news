class StoriesController < ApplicationController

  def index
    if current_user
      @area = current_user.area
      @stories = Story.where(:area => @area)
    end
  end

end
