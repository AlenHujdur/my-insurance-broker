class CreateNacebels < ActiveRecord::Migration[7.0]
  def change
    create_table :nacebels do |t|
      t.integer :level_nr, null: true
      t.string :code, null: true
      t.string :parent_code, null: true
      t.text :label_nl, null: true
      t.text :label_fr, null: true
      t.text :label_de, null: true
      t.text :label_en, null: true
      t.timestamps
    end
  end
end
