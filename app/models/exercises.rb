class Exercise < ActiveRecord::Base
  belongs_to :user
  validates :name, presence: true
  validates :repetition, presence: true
  validates :sets, presence: true
  validates :weight, presence: true

end
