# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
5.times do |i|
  User.create(firstname: "Utili#{i}",
    lastname: "sateur#{i}",
    email: "Utili#{i}.sateur#{i}@gmail.com",
    phone_number: "#{i}#{i+1}#{i+2}#{i+3}",
    status:0,
    encrypted_password: 'password',
    year: Time.new.year)
  Workshop.create(name:"Workshop#{i}", description: "Workshop n°#{i}_ On y fait des trucs", user_id: i, teacher:"Enseignant##{i}", begins: "2016-#{i}-29 12:24:50", ends: "2016-#{i+2}-29 12:24:50", teamgeneration: 0, teamnumber: i+1)
  Project.create(name: "Project##{i}", description:"Projet n°#{i}", workshop_id: i)
end
