# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


Judge.create!(name: 'superadmin', company_name: 'tamu', access_code: 'superadmin', role: 'superadmin')
Judge.create!(name: 'admin', company_name: 'tamu', access_code: 'admin', role: 'admin')
Poster.create!(number:1, presenter: "p1", title: "big data",advisors:"a1",email:"a1@tamu.edu")
Poster.create!(number:2, presenter: "p2", title: "optimization",advisors:"a2",email:"a2@tamu.edu")
Poster.create!(number:3, presenter: "p3", title: "wireless network",advisors:"a3",email:"a3@tamu.edu")
Poster.create!(number:4, presenter: "p4", title: "graph",advisors:"a4",email:"a4@tamu.edu")
Poster.create!(number:5, presenter: "p5", title: "algorithm",advisors:"a5",email:"a5@tamu.edu")
