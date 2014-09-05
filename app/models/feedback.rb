class Feedback < ActiveRecord::Base
  validates :summary, presence: true
  validates :summary, length: {minimum: 5}
  validates :comment, presence: true
  validates :comment, length: {minimum: 10}
end
