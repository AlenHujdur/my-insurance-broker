require 'csv'
require 'zlib'
path = File.join(Rails.root, 'db', 'NACEBEL_2008.csv')
namespace :db do
  desc 'Import NACEBEL_2008 data'
  task import_nacebel: :environment do
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

  end

  def sanitize_string(string)
    # Remove non-UTF characters and invalid byte sequences
    string.encode('UTF-8', 'binary', invalid: :replace, undef: :replace, replace: '')
  end

  def inflate(string)
    decoded = Zlib::Deflate.deflate(string)
    #@inflated = Zlib::Inflate.inflate(@decoded)

    zstream = Zlib::Inflate.new
    buf = zstream.inflate(decoded)
    zstream.finish
    zstream.close
    buf
  end
end
