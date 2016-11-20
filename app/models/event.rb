class Event < ActiveRecord::Base
    
    validates :day, :month, :year, presence: true
    
end
