class Consultation < ApplicationRecord
  belongs_to       :user
  has_one_attached :cons_image
  has_many         :answers
  has_one          :reconciliation

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category

  with_options presence: true do
    validates :cons_title, length: { maximum: 50 }
    validates :category_id
    validates :summary,    length: { maximum: 150 }
    validates :situation,  length: { maximum: 2000 }
    validates :problem,    length: { maximum: 2000 }
  end
end
