
module ProjectAccessConcerns

  include AccessPermissionConcerns
   
  def get_project_access_permissions
    project = self
    current_user = self.class.current_user
    return nil if current_user.nil?
    
    # should have only one 'member' here (db index: unique)
    member = current_user.project_members.find_by(project_id: project.id)
    return get_member_permissions(member)
  end

  # permission: integer (Permission.types['xxxx'])
  def have_project_permission?(permission)
    permissions = get_project_access_permissions
    return false if permissions.blank?
    permissions.each do |permission|
      return false if permission == 0
      return true if permission >= permission
    end
    return false
  end

  def have_project_read_permission?
    return have_project_permission?(Permission.types['view'])
  end

  def have_project_edit_permission?
    return have_project_permission?(Permission.types['edit'])
  end

  def have_project_full_permission?
    return have_project_permission?(Permission.types['full'])
  end

end


