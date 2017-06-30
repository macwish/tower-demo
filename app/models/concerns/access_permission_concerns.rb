
module AccessPermissionConcerns

  # member: team member or project member
  # return: permission list or nil
  def get_member_permissions(member)
    return nil if member.nil?

    # a member may have multiple roles in one project
    roles = member.roles
    return nil if roles.nil?

    # 
    permission_list = []

    roles.each do |role|
      accesses = role.accesses
      next if accesses.nil?  # no 'access' assigned to this role

      # query accesses in 'Project' scope
      access_list = accesses.where(scope: Project.name)
      next if access_list.nil?

      access_list.each do |access|
        permission_list << access.permission
      end
    end

    return permission_list
  end

end


