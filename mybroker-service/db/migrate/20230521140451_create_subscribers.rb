class CreateSubscribers < ActiveRecord::Migration[7.0]
  def change
    create_table :subscribers do |t|
      t.string :name, null: true
      t.string :email, null: false
      t.string :phone, null: true
      t.text :message, null: true
      t.timestamps
    end
    add_index :subscribers, :email, unique: true
  end
end
