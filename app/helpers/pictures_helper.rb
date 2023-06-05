module PicturesHelper
  def current_picture
    @current_picture ||= Picture.find_by(id: session[:user_id])
  end

  def choose_new_or_edit
    if action_name == 'new' || action_name == 'create'
      confirm_pictures_path
    elsif action_name == 'edit'
      picture_path
    end
  end
end