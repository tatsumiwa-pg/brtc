class ConsComment < ApplicationRecord
  belongs_to :user
  belongs_to :consultation

  validates :cons_c_text, presence: true, length: { maximum: 150 }
end
