class Project::TodosController < ProjectBaseController
  
  before_action :set_todo, only: [:show, :edit, :update, :destroy]

  def index
    @title = "Todos"

    @todo_hash = {}
    count = params[:count]
    count = (1..100).include?(count) ? count : 100

    projects = current_user.projects || []
    projects.each do |project|
      todo_lists = project.todo_lists
      next if todo_lists.nil?

      @todo_hash[project] = {}
      todo_lists.each do |todo_list|
        @todo_hash[project][todo_list] = todo_list.todos.order(:updated_at => 'DESC').limit(count)
      end
    end
  end

  def show
    @title = "Todo/Show - #{@todo.id}"
    @comment = Comment.new({
      user_id: current_user,
      commentable: @todo,
    })
    @comments = Comment.where(commentable: @todo, status: 0)
  end

  def edit
    @title = "Todo/Edit - #{@todo.id}"

    @member_hash = @todo.project.member_hash || {}
  end

  def create
    @todo = Project::Todo.new(todo_params_for_create)

    respond_to do |format|
      if @todo.save
        format.html { redirect_to @todo, notice: 'Todo was successfully created.' }
        format.json { render :show, status: :created, location: @todo }
      else
        format.html { render :index }
        format.json { render json: @todo.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @member_hash = @todo.project.member_hash || {}
    respond_to do |format|
      if @todo.update(todo_params_for_update)
        format.html { redirect_to @todo, notice: 'Todo was successfully updated.' }
        format.json { render :show, status: :ok, location: @todo }
      else
        format.html { render :edit }
        format.json { render json: @todo.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @todo.destroy
        format.html { redirect_to project_todos_url, notice: 'Todo was successfully destroyed.' }
        format.json { head :no_content }
      else
        format.html { redirect_to project_todos_url, notice: @todo.errors.any? ? @todo.errors.full_messages.join('. ') : 'Todo destroy error.' }
        format.json { head 400 }
      end
    end
  end

  private
    
    def set_todo
      @todo = Project::Todo.find(params[:id])
    end

    def todo_params_for_create
      params.require(:project_todo).permit(:todo_list_id, :content, :assigned_to_member_id, :deadline, :completed, :trashed)
    end

    def todo_params_for_update
      params.require(:project_todo).permit(:content, :assigned_to_member_id, :deadline, :completed, :trashed)
    end

end
