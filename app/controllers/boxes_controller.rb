class BoxesController < ApplicationController
  def index
    @boxes = current_user.boxes
  end

  def new
    @box = Box.new
  end

  def create
    box = Box.new(box_params)
    if box.save
      redirect_to box
    else
      render "new"
    end
  end

  def show
    @box = Box.find(params[:id])
  end

  private

  def box_params
    params.require(:box).permit(:name, :room, :content)
  end
end
