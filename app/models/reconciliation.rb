class Reconciliation < ApplicationRecord
  belongs_to :consultation

  validates :rec_text, presence: true, length: { maximum: 40 }
end
