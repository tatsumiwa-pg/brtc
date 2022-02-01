class CreateAnsComments < ActiveRecord::Migration[6.0]
  def change
    create_table :ans_comments do |t|
      t.string     :ans_c_text, null: false
      t.references :user,       null: false, foreign_key: true
      t.references :answer,     null: false, foreign_key: true
      t.timestamps
    end
  end
end
