# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
def encrypt_password(password)
    password_salt = BCrypt::Engine.generate_salt
    password_hash = BCrypt::Engine.hash_secret(password,password_salt)
    return password_hash
end
5.times do |i|
User.create(prenom: "Utili#{i}", nom: "sateur#{i}", email: "Utili#{i}.sateur#{i}@gmail.com",phone_number: "#{i}#{i+1}#{i+2}#{i+3}", year: Time.new.year)
Workshop.create(name: "Workshop#{i}", description: "Workshop n°#{i}", begins: "2015-05-#{i}", ends: "2015-05-#{i+10}")
end
