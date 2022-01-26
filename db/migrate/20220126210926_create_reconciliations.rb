class CreateReconciliations < ActiveRecord::Migration[6.0]
  def change
    create_table :reconciliations do |t|
      t.string     :rec_text,     null: false
      t.references :consultation, null: false, foreign_key: true
      t.timestamps
    end
  end
end
