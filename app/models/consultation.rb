class Consultation < ApplicationRecord
  belongs_to :user
  belongs_to :category

  with_options presence: true do
    :cons_title, length: { maximum: 50 }
    :summary,    length: { maximum: 150 }
    :situation,  length: { maximum: 2000 }
    :problem,    length: { maximum: 2000 }
    :category_id, numericality: { message: "can't be blank"}
  end
end
