# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require 'csv'
path = File.join(Rails.root, 'db', 'NACEBEL_2008.csv')
begin
  CSV.foreach(path, headers: true, col_sep: ';', encoding: 'iso-8859-1:utf-8') do |row|
    Nacebel.create!(
      level_nr: row['Level nr']&.to_i,
      code: row['Code'].to_s,
      parent_code: row['Parent code'].to_s,
      label_nl: row['Label NL'].to_s,
      label_fr: row['Label FR'].to_s,
      label_de: row['Label DE'].to_s,
      label_en: row['Label EN'].to_s
    )
  rescue
    SystemEvent.create!(event_type: 'error', event_name: 'import_nacebel', event_value: row.to_s)
  end
end
