class CreateRequestedQuotes < ActiveRecord::Migration[7.0]
  def change
    create_table :requested_quotes do |t|
      t.references :subscriber, null: false, foreign_key: true
      t.boolean :natural_person, null: false, default: false
      t.string :enterprise_number, null: false, limit: 10
      t.string :legal_name, null: false
      t.decimal :annual_revenue, precision: 10, scale: 2
      t.string :deductible_formula, null: true, default: 'medium'
      t.string :coverage_ceiling_formula, null: true, default: 'small'
      if ActiveRecord::Base.connection.adapter_name == 'PostgreSQL'
      t.text :nacebel_codes, null: false,array: true, default: [] # for sqlite3 use '[]'
      else
      t.text :nacebel_codes, null: false, default: '[]' # for sqlite3 use '[]'
      end
      t.timestamps
    end
  end
end
