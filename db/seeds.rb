# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

admin = Admin.create({email: "prashansa_admin@kk.com",password: "123456",password_confirmation: "123456",mobile: "1234567891",admin_key: "abc123"})
trafficpolice= Trafficpolice.create({email: "prashansa_police@kk.com",password: "123456",password_confirmation: "123456",mobile: "1234567891",first_name: "prashansa_aaa",last_name: "prashansa_ccc",aadhar_no:"1111111111111",dob: DateTime.now.to_date,police_key: "123abc",admin_id: admin.id,address: "c-123 rohini"})
citizen = Citizen.create({email: "prashansa_citizen@kk.com",password: "123456",password_confirmation: "123456",mobile: "1234567891",first_name: "prashansa_aba",last_name: "prashansa_cbc",aadhar_no:"1111121111111",dob: DateTime.now.to_date,address: "c-123 rohini"})
vehicle = Vehicle.create({name: "activa",category: "scooty",dop: DateTime.now.to_date,citizen_id: citizen.id,registration_no: "dl9351232"})
pollution = Pollution.create({pollution_no: "123abc",date_of_issue: DateTime.now.to_date,date_of_expiry:DateTime.tomorrow.to_date,place_of_issue: "prashansa ka ghar",vehicle_id: vehicle.id,citizen_id: citizen.id})
challantype = Challantype.create({name: "helmet",amount: "1200", description: "helment nahi pehna",category:"traffic"})
challan = Challan.create({challantype_id: challantype.id,date_of_issue:DateTime.now.to_date,time_of_issue: Time.now,latitude: 12.12,longitude: 121.21,address: "ghar pe",vehicle_id:vehicle.id,trafficpolice_id: trafficpolice.id,citizen_id:citizen.id,due_date:DateTime.tomorrow.to_date})