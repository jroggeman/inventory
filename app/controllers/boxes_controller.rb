class BoxesController < ApplicationController
  def index
    @boxes = current_user.boxes
  end

  def new
    @box = Box.new
  end
end
