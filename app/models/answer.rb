class Answer < ApplicationRecord
  belongs_to :user
  belongs_to :consultation
  has_one_attached :image
end
