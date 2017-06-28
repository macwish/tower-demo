module NavHelper

  def active_class(name)
    return 'active' if controller.controller_name == name
  end

end
