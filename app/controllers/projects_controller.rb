class ProjectsController < ProjectBaseController
  
  before_action :set_project, only: [:show]
  before_action :check_access_permission, only: [:show]

  def list
    @title = "Project/List"

    @projects = current_user.projects || []
  end

  def show
    @title = "Project/Show - #{@project.name}"
  end

  private
    
    def set_project
      @project = Project.find(params[:id])
    end
    
end
