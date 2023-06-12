class Nacebel < ApplicationRecord
  #show only label_fr with medical for the sake of the challenge and where code is 5 digits length and level_nr is 5
  scope :show_only_level5_for_medicine, -> { where("level_nr = 5 AND LENGTH(code) = 5 AND label_fr LIKE '%médecin%'")}
end
