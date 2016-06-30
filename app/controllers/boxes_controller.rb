class BoxesController < ApplicationController
  def index
    @boxes = current_user.boxes
  end
end
