class Exercise < ActiveRecord::Base
  belongs_to :user
  validates :name, presence: true
  validates :repetition, presence: true
  validates :sets, presence: true

  # def self.valid_params?(params)
  #   !params[:name].empty? && !params[:repetition].empty? &&
  #   !params[:sets].empty?
  #   binding.pry
  # end
end
