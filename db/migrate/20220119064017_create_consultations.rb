class CreateConsultations < ActiveRecord::Migration[6.0]
  def change
    create_table :consultations do |t|
      t.string     :cons_title,  null: false
      t.integer    :category_id, null: false
      t.string     :summary,     null: false
      t.text       :situation,   null: false
      t.text       :problem,     null: false
      t.references :user,        null: false, foreign_key: true
      t.timestamps
    end
  end
end
