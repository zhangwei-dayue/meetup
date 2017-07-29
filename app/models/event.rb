class Event < ApplicationRecord

  validates_presence_of :title
  belongs_to :user, :optional => true
  has_many :comments
end
