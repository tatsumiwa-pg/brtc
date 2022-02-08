class CreateProfiles < ActiveRecord::Migration[6.0]
  def change
    create_table :profiles do |t|
      t.integer    :age,         null: false
      t.string     :job,         null: false
      t.string     :skills,      null: false
      t.string     :address,     null: false
      t.string     :cat_exp,     null: false
      t.integer    :family_type, null: false
      t.integer    :house_env,   null: false
      t.text       :my_cats,     null: false
      t.text       :introduce,   null: false
      t.references :user,        null: false, foreign_key: true
      t.timestamps
    end
  end
end
