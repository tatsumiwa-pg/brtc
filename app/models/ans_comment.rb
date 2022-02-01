class AnsComment < ApplicationRecord
  belongs_to :user
  belongs_to :answer

  validates :ans_c_text, presence: true, length: { maximum: 150 }
end
