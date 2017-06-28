class ProjectBase < ApplicationRecord

  self.abstract_class = true
  
  before_update  :check_editable_permissions
  before_destroy :check_removable_permissions

  # return: ralated project
  def project
    raise NotImplementedError, 'subclasses must define "project"'
  end

  private

    # ensure current user have the right permission to the project
    def check_readable_permissions
      raise RuntimeError.new('nil self.project') if self.project.nil?
      if not self.project.have_project_read_permission?
        errors.add(:project, :permission_deny_unreadable)
        throw :abort
      end
    end

    def check_editable_permissions
      raise RuntimeError.new('nil self.project') if self.project.nil?
      if not self.project.have_project_edit_permission?
        errors.add(:project, :permission_deny_uneditable)
        # in Rails 5 you have to 'throw :abort' in 'before_destroy' callback
        # to stop destroy
        throw :abort 
      end
    end

    def check_removable_permissions
      raise RuntimeError.new('nil self.project') if self.project.nil?
      if not self.project.have_project_full_permission?
        errors.add(:project, :permission_deny_unremovable)
        throw :abort
      end
    end

end
