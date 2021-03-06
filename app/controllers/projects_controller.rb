class ProjectsController < ApplicationController
  before_filter :get_user

  def index
    if @user.nil?
      @projects = Project.all
    else
      @project = @user.projects
    end
  end

  def new
    @project = Project.new
  end

  def show
    if @user.nil?
      @project = Project.find(params[:id])
      send_file @project.document.path, :filename => @project.document_file_name,:content_type => @project.document_content_type
    else
      @projects = @user.projects
      render 'show'
    end
  end

  def create
    @project = Project.new(file_params)
    if @project.save
      flash[:success] = "Successfully uploaded project"
      redirect_to root_url
    else
      flash.now[:error] = 'Invalid matric_number/password combination'
      render 'new'
    end
  end

  private

  def file_params
    params.require(:project).permit(:document)
  end

  def get_user
    @user = User.find(params[:user_id]) if params[:user_id]
  end
end
