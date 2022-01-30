class CreateConsComments < ActiveRecord::Migration[6.0]
  def change
    create_table :cons_comments do |t|
      t.string     :conc_c_text,  null: false
      t.references :user,         null: false, foreign_key: true
      t.references :consultation, null: false, foreign_key: true
      t.timestamps
    end
  end
end
