class Reconciliation < ApplicationRecord
  belongs_to :consultation

  validates :rec_text, length: { maximum: 40 }
end
