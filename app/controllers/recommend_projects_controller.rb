class RecommendProjectsController < ApplicationController
  before_action :get_project, except: [:new, :create, :index, :unchecked_projects]

  def index
    @page_index = 0
    projects = RecommendProject.approved
    projects = projects.where(name: params[:name]) if params[:name].present?
    projects = projects.where(created_at: params[:created_at]) if params[:created_at].present?
    projects = projects.tagged_with(params[:tag]) if params[:tag].present?
    projects = projects.custom_sort(params[:sort])
    @projects = projects.page(params[:page]).per(4)
  end

  def new
    @page_index = 1
    @project = RecommendProject.new
  end

  def create
    project = current_user.recommend_projects.new(project_params)
    if project.save
      flash[:notice] = t("views.notice.project_create")
    else
      flash[:alert] = project.errors.full_messages.join(', ')
    end

    redirect_to recommend_project_path(project)
  end

  def show
    @comment = @project.user_comments.new
    @comments = @project.user_comments.includes(:user).with_rich_text_content_and_embeds.order(created_at: :desc).page(params[:page]).per(10)
  end

  def edit
  end

  def update
    if @project.update(project_params)
      flash[:notice] = t("views.notice.project_update")
    else
      flash[:alert] = @project.errors.full_messages.join(', ')
    end

    redirect_to recommend_project_path(@project)
  end

  def destroy
    if @project.destroy
      flash[:notice] = t("views.notice.project_delete")
    else
      flash[:alert] = @project.errors.full_messages.join(', ')
    end

    redirect_to recommend_projects_path
  end

  def add_comment
    comment = @project.user_comments.new(comment_params)
    comment.rating = params[:rating]
    if comment.save
      flash[:notice] = t("views.notice.add_comment")
    else
      flash[:alert] = comment.errors.full_messages.join(', ')
    end

    redirect_to recommend_project_path(@project)
  end

  private
  def get_project
    @project = RecommendProject.find params[:id]
  end

  def project_params
    params.require(:recommend_project).permit(:name, :website, :desc, :reason, :tag_list, :logo, :cost)
  end

  def comment_params
    params.require(:user_comment).permit(:user_id, :content)
  end
end
