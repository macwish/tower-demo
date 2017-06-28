class Team::Member::Role < ApplicationRecord

  self.inheritance_column = nil

  enum type: {
    'unset'  => 0,
    'staff'  => 1,
    'leader' => 2,
  }

  belongs_to :member, class_name: 'Team::Member'

  has_many :accesses, as: :accessrelated,  dependent: :destroy

  validates :member_id, :type, :presence => true
  validates :type, inclusion: types.keys
  
  def name
    return type.to_s
  end

end
