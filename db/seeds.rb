
# 1. create users
user_count = User.all.size
if user_count == 0
  puts 'will create users...'
  User.transaction do
    begin
      (1..20).each do |i|
        username = 'user' + i.to_s
        User.create!({
          email: username + '@foo.com',
          password: 'my_raw_passwd',
          name: username,
          status: 0,
          removed: false,
        })
      end
    rescue ActiveRecord::StatementInvalid => e
      # ignored for db rollback
      puts "create users error: #{e}"
    end
  end
else
  puts "user_count: #{user_count}"
end

# 2. create auths
auth_count = Auth.all.size
if auth_count == 0
  puts 'will create auths...'
  Auth.transaction do
    begin
      User.all.each do |user|
        token = 'access_token_' + user.id.to_s
        Auth.create!({
          user_id: user.id,
          token: token,
        })
      end
    rescue ActiveRecord::StatementInvalid => e
      # ignored for db rollback
      puts "create auths error: #{e}"
    end
  end
else
  puts "auth_count: #{auth_count}"
end

# 3. create teams
team_count = Team.all.size
if team_count == 0
  puts 'will create teams...'
  user1 = User.find(10)
  user2 = User.find(11)
  Team.transaction do
    begin
      Team.create!([
        {
          name: 'team_1',
          creator_id: user1.id,
          admin_id: user1.id,
          removed: false
        },
        {
          name: 'team_2',
          creator_id: user2.id,
          admin_id: user2.id,
          removed: false
        },
      ])
    rescue ActiveRecord::StatementInvalid => e
      # ignored for db rollback
      puts "create teams error: #{e}"
    end
  end
else
  puts "team_count: #{team_count}"
end

# 4. create team members
team_member_count = Team::Member.all.size
if team_member_count == 0
  puts 'will create team members...'
  team = Team.find(1)
  users = User.where("id >= ?", 10).limit(5)
  Team::Member.transaction do
    begin
      users.each do |user|
        Team::Member.create!({
          team_id: team.id,
          user_id: user.id,
        })
      end
    rescue ActiveRecord::StatementInvalid => e
      # ignored for db rollback
      puts "create team members error: #{e}"
    end
  end
else
  puts "team_member_count: #{team_member_count}"
end

# 5. create team member roles
team_member_role_count = Team::Member::Role.all.size
if team_member_role_count == 0
  puts 'will create team member roles...'
  Team::Member::Role.transaction do
    begin
      Team.find(1).members.each do |member|
        Team::Member::Role.create!({
          member_id: member.id,
          type: 'staff'
        })
      end
    rescue ActiveRecord::StatementInvalid => e
      # ignored for db rollback
      puts "create team member roles error: #{e}"
    end
  end
else
  puts "team_member_role_count: #{team_member_role_count}"
end

# 6. create projects
project_count = Project.all.size
if project_count == 0
  puts 'will create projects...'
  team = Team.find(1)
  raise RuntimeError.new('nil team') if team.nil? 
  Project.transaction do
    begin
      Project.create!([
        {
          team_id: team.id,
          name: 'project_1',
          description: 'project_1 desc',
          type: 'standard',
          is_private: true,
          status: 0,
          archived: false,
          removed: false
        },
        {
          team_id: team.id,
          name: 'project_2',
          description: 'project_2 desc',
          type: 'standard',
          is_private: true,
          status: 0,
          archived: false,
          removed: false
        }
      ])
    rescue ActiveRecord::StatementInvalid => e
      # ignored for db rollback
      puts "create projects error: #{e}"
    end
  end
else
  puts "project_count: #{project_count}"
end

# 7. create project members
project_member_count = Project::Member.all.size
if project_member_count == 0
  puts 'will create project members...'
  team = Team.find(1)
  project = Project.where(team_id: team.id).first
  Project::Member.transaction do
    begin
      Team.find(1).members.each do |member|
        Project::Member.create!({
          project_id: project.id,
          user_id: member.user_id,
        })
      end

      # user-1 belongs to two projects.
      Project::Member.create!({
        project_id: Project.find(2).id,
        user_id: User.find(10).id,
      })
    rescue ActiveRecord::StatementInvalid => e
      # ignored for db rollback
      puts "create project members error: #{e}"
    end
  end
else
  puts "project_member_count: #{project_member_count}"
end

# 8. create project member roles
project_member_role_count = Project::Member::Role.all.size
if project_member_role_count == 0
  puts 'will create project member roles...'
  Project::Member::Role.transaction do
    begin
      Project.find(1).members.each do |member|
        Project::Member::Role.create!({
          member_id: member.id,
          type: 'backend_developer'
        })
      end

      # 
      Project.find(2).members.each do |member|
        Project::Member::Role.create!({
          member_id: member.id,
          type: 'ui_designer'
        })
      end
    rescue ActiveRecord::StatementInvalid => e
      # ignored for db rollback
      puts "create project member roles error: #{e}"
    end
  end
else
  puts "project_member_role_count: #{project_member_role_count}"
end

# 9. create project access
project_access_count = Access.where(scope: Project.name).size
if project_access_count == 0
  puts 'will create project access...'
  Access.transaction do
    begin
      Project.find(1).members.each do |member|
        member.roles.each do |role|
          Access.create!({
            scope: Project.name,
            accessrelated: role,
            permission: Permission.types['full'],
          })
        end
      end

      # 
      Project.find(2).members.each do |member|
        member.roles.each do |role|
          Access.create!({
            scope: Project.name,
            accessrelated: role,
            permission: Permission.types['edit'],
          })
        end
      end
    rescue ActiveRecord::StatementInvalid => e
      # ignored for db rollback
      puts "create project access error: #{e}"
    end
  end
else
  puts "project_access_count: #{project_access_count}"
end

# 10. create project todo_list
project_todo_list_count = Project::TodoList.all.size
if project_todo_list_count == 0
  puts 'will create project todo_list...'
  project = Project.find(1)
  Project::TodoList.transaction do
    begin
      Project::TodoList.create!([
        {
          project_id: project.id,
          name: 'todo_list_1',
          description: 'todo_list_1 desc',
          trashed: false,
        },
        {
          project_id: project.id,
          name: 'todo_list_2',
          description: 'todo_list_2 desc',
          trashed: false,
        }
      ])
    rescue ActiveRecord::StatementInvalid => e
      # ignored for db rollback
      puts "create project todo_list error: #{e}"
    end
  end
else
  puts "project_todo_list_count: #{project_todo_list_count}"
end

# 11. create project todos
project_todo_count = Project::Todo.all.size
if project_todo_count == 0
  puts 'will create project todos...'
  todo_list = Project::TodoList.find(1)
  user = todo_list.project.members.first
  
  # ensure Model.current_user is nil here 
  # (means not to push events to brower)
  ApplicationRecord.current_user = nil

  Project::Todo.transaction do
    begin
      (1..10).each do |i|
        content = 'todo_' + i.to_s + ' content...'
        Project::Todo.create!({
          todo_list_id: todo_list.id,
          content: content,
          assignd_to_member_id: user.id,
          deadline: 50.days.from_now.to_i,
          completed: false,
          trashed: false,
        })
      end
    rescue ActiveRecord::StatementInvalid => e
      # ignored for db rollback
      puts "create project todos error: #{e}"
    end
  end
else
  puts "project_todo_count: #{project_todo_count}"
end

# 12. create project todo_items
project_todo_item_count = Project::TodoItem.all.size
if project_todo_item_count == 0
  puts 'will create project todo_items...'
  todo_list = Project::TodoList.find(1)
  todo = todo_list.todos.first
  Project::TodoItem.transaction do
    begin
      (1..3).each do |i|
        description = 'todo_item_' + i.to_s + ' desc'
        Project::TodoItem.create!({
          todo_id: todo.id,
          description: description,
          completed: false,
        })
      end
    rescue ActiveRecord::StatementInvalid => e
      # ignored for db rollback
      puts "create project todo_items error: #{e}"
    end
  end
else
  puts "project_todo_item_count: #{project_todo_item_count}"
end

# 13. create comments
comment_count = Comment.all.size
if comment_count == 0
  puts 'will create comments...'
  user = User.find(10)
  todo_list = Project::TodoList.find(1)
  todo = todo_list.todos.first
  Comment.transaction do
    begin
      (1..10).each do |i|
        content = 'comment_' + i.to_s + ' content...'
        Comment.create!({
          content: content,
          user_id: user.id,
          commentable: todo,
        })
      end
    rescue ActiveRecord::StatementInvalid => e
      # ignored for db rollback
      puts "create comments error: #{e}"
    end
  end
else
  puts "comment_count: #{comment_count}"
end

# 14. create events
event_count = Event.all.size
if event_count < 200
  puts 'will create events...'
  user = User.find(10)
  project = Project.find(1)
  raise RuntimeError.new('nil project') if project.nil?
  todo_list = project.todo_lists.first
  todo = todo_list.todos.first

  # ensure Model.current_user is nil here 
  # (means not to push events to brower)
  ApplicationRecord.current_user = nil
  
  Event.transaction do
    begin
      (1..200).each do |i|
        content = 'event_' + i.to_s + ' content...'
        Event.create!({
          type: 'feed',
          user_id: user.id,
          action: 'created',
          target: todo.class.name,
          time: Time.now.to_i,
          info: {foo: 'bar'},
          eventrelated: todo,
          originrelated: project
        })
      end
    rescue ActiveRecord::StatementInvalid => e
      # ignored for db rollback
      puts "create events error: #{e}"
    end
  end
else
  puts "event_count: #{event_count}"
end
