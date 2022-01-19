class Consultation < ApplicationRecord
  belongs_to :user
  belongs_to :category

  with_options presence: true do
    validates :cons_title, length: { maximum: 50 }
    validates :summary,    length: { maximum: 150 }
    validates :situation,  length: { maximum: 2000 }
    validates :problem,    length: { maximum: 2000 }
    validates :category_id, numericality: { message: "can't be blank"}
  end
end
