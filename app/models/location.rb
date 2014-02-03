class Location < ActiveRecord::Base
  has_many :actions, dependent: :destroy
  accepts_nested_attributes_for :actions
  validates :location, presence: true,
                       uniqueness: { case_sensitive: false } 
                       
  def add_action(added_action)
    actions.build(action: added_action)
  end
end
