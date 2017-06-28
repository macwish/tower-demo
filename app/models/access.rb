class Access < ApplicationRecord

  belongs_to :accessrelated, polymorphic: true, optional: true

  validates :scope, :permission, :presence => true
  
end
