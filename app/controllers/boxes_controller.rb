class BoxesController < ApplicationController
  before_action :set_box, only: [:show, :edit, :update]

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
  end

  def edit
  end

  def update
    if @box.update(box_params)
      redirect_to @box
    else
      render "edit"
    end
  end

  private

  def box_params
    params.require(:box).permit(:name, :room, :content)
  end

  def set_box
    @box = current_user.boxes.find_by_id(params[:id])
    redirect_to current_user if @box.nil?
  end
end
