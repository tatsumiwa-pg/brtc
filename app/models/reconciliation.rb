class Reconciliation < ApplicationRecord
  belongs_to :consultation

  validates :rec_text, presence: true, length: { maximum: 50 }
end
