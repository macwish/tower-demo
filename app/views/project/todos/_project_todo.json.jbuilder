json.extract! todo, :id, :todo_list_id, :content, :assigned_to_member_id, :deadline, :creator_id, :completed, :trashed, :created_at, :updated_at
json.url project_todo_url(todo, format: :json)
