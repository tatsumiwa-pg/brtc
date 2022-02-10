class Profile < ApplicationRecord
  belongs_to :user
  has_one_attached :user_image

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :age
  belongs_to :family_type
  belongs_to :house_env

  with_options presence: true do
    validates :age_id, :family_type_id, :house_env_id, numericality: true
    validates :job,          length: { maximum: 100 }
    validates :skills,       length: { maximum: 200 }
    validates :address,      length: { maximum: 50 }
    validates :cat_exp,      length: { maximum: 200 }
    validates :my_cats,      length: { maximum: 500 }
    validates :introduction, length: { maximum: 1000 }
  end
end
