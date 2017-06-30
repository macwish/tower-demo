class ProjectBaseController < ApplicationController

  def check_access_permission
    raise RuntimeError.new('nil @project') if @project.nil?
    permission_denied and return if not @project.have_project_read_permission?
  end

end
