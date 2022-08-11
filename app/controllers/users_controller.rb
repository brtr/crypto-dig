class UsersController < ApplicationController
  def login
    user = User.where(address: params[:address]).first_or_create
    session[:user_id] = user.id

    render json: {success: true}
  end

  def logout
    session[:user_id] = nil if session[:user_id]

    render json: {success: true}
  end

  def projects
    if current_user
      @projects = current_user.recommend_projects.with_rich_text_desc_and_embeds.order(created_at: :desc).page(params[:page]).per(10)
    else
      redirect_to root_path, alert: t("views.error.no_user")
    end
  end
end
