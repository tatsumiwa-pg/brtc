class CreateAnswers < ActiveRecord::Migration[6.0]
  def change
    create_table :answers do |t|
      t.string     :ans_title,    null: false
      t.text       :ans_text,     null: false
      t.references :user,         null: false, foreign_key: true
      t.references :consultation, null: false, foreign_key: true
      t.timestamps
    end
  end
end
