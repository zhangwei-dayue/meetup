class Comment < ApplicationRecord
  validates_presence_of :name
  belongs_to :event
  belongs_to :user
end
