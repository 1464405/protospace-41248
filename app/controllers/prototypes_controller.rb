class PrototypesController < ApplicationController
  before_action :authenticate_user!,only: [:edit, :new,:update,:destroy]
  before_action :move_to_index,only: [:edit,:update ]

  def index
    @prototypes = Prototype.includes(:user).order("created_at DESC")
    

  end


  def show

    @prototype = Prototype.find(params[:id])
    @comment = Comment.new
    @comments = @prototype.comments.includes(:user)

  end


  def new

    @prototype = Prototype.new

  end
  def create 
    @prototype = Prototype.new(prototype_params)
    if @prototype.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end
  def edit

    @prototype = Prototype.find(params[:id])
    unless current_user.id == @prototype.user.id
      redirect_to action: :index
    end
  end
  def update

    @prototype = Prototype.find(params[:id])
    if @prototype.update(prototype_params)
      redirect_to prototype_path(@prototype.id)
    else
      render :edit, status: :unprocessable_entity
    end
  end
  def destroy

    @prototype = Prototype.find(params[:id])
    @prototype.destroy
    redirect_to root_path
  end
  private
  def prototype_params
    params.require(:prototype).permit(:image, :title,:catch_copy,:concept).merge(user_id: current_user.id)
  end

  def move_to_index
   
  end

  
end