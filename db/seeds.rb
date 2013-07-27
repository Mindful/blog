# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
# cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
# Mayor.create(name: 'Emanuel', city: cities.first)

    User.create(name: 'Josh', email: 'joshuabtanner@gmail.com', password:'jetblogtime', password_confirmation:'jetblogtime')
    User.create(name: 'Zoe', email: 'zwiss0@gmail.com', password: 'imapassword', password_confirmation: 'imapassword')
    #Zoe should go here