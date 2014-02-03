class Action < ActiveRecord::Base
  belongs_to :location
  validates :location_id, presence: true
  validates :action, presence: true
  validates :virgin, presence: true, :on => :update
  validates_uniqueness_of :action, scope: :location_id
end
