class BoxesController < ApplicationController
  before_action :set_box, only: [:show, :edit, :update, :destroy]

  def index
    @boxes = current_user.boxes
  end

  def new
    @box = Box.new
  end

  def create
    box = Box.new(box_params)
    box.user = current_user
    if box.save
      redirect_to box
    else
      render "new"
    end
  end

  def show
    respond_to do |format|
      format.html
      format.svg { render qrcode: box_url(@box), l: :m, unit: 6 }
    end
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

  def destroy
    @box.destroy!
    redirect_to boxes_path
  end

  private

  def box_params
    params.require(:box).permit(:name, :room, :contents)
  end

  def set_box
    @box = current_user.boxes.find_by_id(params[:id])
    redirect_to current_user if @box.nil?
  end
end
