class Subscriber < ApplicationRecord
  #Subscriber could be a lead / prospect / customer. I will use subscriber for now.
  validates :email, presence: true, uniqueness: true
end
