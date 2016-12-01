class Event < ApplicationRecord
    
    validates :day, :month, :year, presence: true
    
end
