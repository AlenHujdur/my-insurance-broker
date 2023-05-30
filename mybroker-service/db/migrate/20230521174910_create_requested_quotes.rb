class CreateRequestedQuotes < ActiveRecord::Migration[7.0]
  def change
    create_table :requested_quotes do |t|
      t.references :subscriber, null: false, foreign_key: true
      t.string :business_type
      t.string :industry
      t.decimal :policy_limit, precision: 10, scale: 2
      t.decimal :deductible, precision: 10, scale: 2
      t.integer :coverage_period
      t.timestamps
    end
  end
end
