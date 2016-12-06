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

Event.create!(day: '01', month: '01', year: '2016', max_poster_number: 30)