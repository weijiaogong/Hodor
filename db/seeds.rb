# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

if Judge.count == 0
    Judge.create!(name: 'superadmin', company_name: 'tamu', access_code: 'superadmin', role: 'superadmin')
end

Event.find_or_create_by(id: 1)  do |event|
  event.max_poster_number = 30
  event.day = '01'
  event.month = '01'
  event.year = '2016'
end