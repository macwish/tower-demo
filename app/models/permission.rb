# Note:
# 'Permission' is an model without db table.
# inherited from 'ActiveRecord::Base' for 'enum'
class Permission < ActiveRecord::Base
  
  self.abstract_class = true
  
  # Note:
  # larger type-value permission always override the small one.
  # 
  enum type: {
    'deny'   => 0,  # no permission
    'view'   => 1,  # readable
    'edit'   => 2,  # view + writable
    'remove' => 3,  # edit + removable
    'full'   => 4,  # full permission
  }

  validates :type, inclusion: types.keys

end
