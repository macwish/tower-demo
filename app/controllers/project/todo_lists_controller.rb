class Project::TodoListsController < ProjectBaseController

  before_action :set_project_todo_list, only: [:show]

  def show
    @title = "TodoList/Show - #{@todo_list.name}"
    @todo = Project::Todo.new(todo_list: @todo_list)
    @member_hash = @todo.project.member_hash || {}
  end

  private

    def set_project_todo_list
      @todo_list = Project::TodoList.find(params[:id])
    end

end
