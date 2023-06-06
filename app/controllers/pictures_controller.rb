class PicturesController < ApplicationController
  skip_before_action :login_required, only: [:new, :create]
  before_action :set_picture, only: [ :show, :edit, :update, :destroy ]

  def index
    @pictures = Picture.all
  end

  def show
    @favorite = current_user.favorites.find_by(picture_id: @picture.id)
  end

  def new
    if params[:back]
      @picture = Picture.new(picture_params)
    else
      @picture = Picture.new
    end
  end

  def edit
    @picture = Picture.find(params[:id])
    if @picture.user == current_user
        render :edit
    else
      flash[:notice] = "権限がありません"
      redirect_to pictures_path
    end
  end

  def create
    @picture = Picture.new(picture_params)
    @picture = current_user.pictures.build(picture_params)

    if params[:back]
      render :new
    else
      if @picture.save
        redirect_to pictures_path
      else
        render :new
      end
    end
  end

  def confirm
    @picture = current_user.pictures.build(picture_params)
    render :new if @picture.invalid?
  end

  def update
    @picture = Picture.find(params[:id])
    if @picture.update(picture_params)
      redirect_to pictures_path, notice: "投稿が更新されました。"
    else
      render :edit
    end
  end

  def destroy
    if @picture.user == current_user
    @picture.destroy
      redirect_to pictures_path, notice: "投稿が削除されました。"
    else
      flash[:notice] = "権限がありません"
      redirect_to pictures_path
    end
  end

  private

  def set_picture
    @picture = Picture.find(params[:id])
  end

  def picture_params
    params.require(:picture).permit(:image, :image_cache, :content)
  end
end