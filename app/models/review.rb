class Review < ApplicationRecord
  belongs_to :answer

  validates :point, presence: true
end
