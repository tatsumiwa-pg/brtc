class Answer < ApplicationRecord
  belongs_to        :user
  belongs_to        :consultation
  has_one_attached  :ans_image
  has_many          :ans_comments
  has_one           :review

  with_options presence: true do
    validates :ans_title, length: { maximum: 40 }
    validates :ans_text,  length: { maximum: 2000 }
  end
end
