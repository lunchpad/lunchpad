# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Account.delete_all
AccountOwnership.delete_all
AvailableMenuItem.delete_all
MenuItem.delete_all
OffDay.delete_all
OrderedItem.delete_all
Order.delete_all
School.delete_all
Vendor.delete_all

super_admin = User.create(email: 'email@gmail.com',
                          password: 'password',
                          password_confirmation: 'password',
                          first_name: 'Lunch',
                          last_name: 'Pad')


willow = School.create(name: 'Willow Oak',
                       description: 'Charter school',
                       motto: 'random motto',
                       phone: Faker::PhoneNumber.phone_number,
                       address: Faker::Address.street_address)

account = Account.create(school: willow,
                         balance: 0,
                         name: 'Student 1',
                         section: 3)

user = User.create(email: 'deedeelavinder@gmail.com',
                   first_name: 'DeeDee',
                   last_name: 'Lavinder',
                   password: 'password',
                   password_confirmation: 'password')

user = User.create(email: 'nickpassarella@gmail.com',
                   first_name: 'Nick',
                   last_name: 'Passarella',
                   password: 'password',
                   password_confirmation: 'password')

user = User.create(email: 'kheang@gmail.com',
                   first_name: 'Kheang',
                   last_name: 'Lim',
                   password: 'password',
                   password_confirmation: 'password')

super_admin.add_role :admin, willow

AccountOwnership.create(user: super_admin, account: account)

vendor_ht = Vendor.create(name: 'Harris Teeter',
              email: 'email@gmail.com',
              phone_number: '555-555-5555',
              school: willow)

vendor_cat = Vendor.create(name: 'Carolina Catering Company',
                          email: 'carolina@gmail.com',
                          phone_number: '555-555-5555',
                          school: willow)

menu_items = []

menu_items << MenuItem.create(vendor: vendor_ht,
                              name: 'Pizza',
                              description: 'cheese',
                              price: 300)

menu_items << MenuItem.create(vendor: vendor_ht,
                              name: 'Burger',
                              description: 'veggie',
                              price: 400)

menu_items << MenuItem.create(vendor: vendor_cat,
                              name: 'Salad',
                              description: 'garden',
                              price: 500)

menu_items << MenuItem.create(vendor: vendor_cat,
                              name: 'California roll',
                              description: 'veggie',
                              price: 800)

menu_items << MenuItem.create(vendor: vendor_ht,
                              name: 'Chicken nuggets',
                              description: 'not veggie',
                              price: 400)

menu_items << MenuItem.create(vendor: vendor_ht,
                              name: 'Turkey sandwich',
                              description: 'wheat bread',
                              price: 600)

menu_items << MenuItem.create(vendor: vendor_cat,
                              name: 'Veggie wrap',
                              description: 'veggie',
                              price: 400)

menu_items << MenuItem.create(vendor: vendor_ht,
                              name: 'Ham sandwich',
                              description: 'wheat bread',
                              price: 400)

menu_items << MenuItem.create(vendor: vendor_cat,

                              name: 'Veggie wrap',
                              description: 'veggie',
                              price: 300)

menu_items << MenuItem.create(vendor: vendor_ht,
                              name: 'Sandwich',
                              description: 'wheat bread',
                              price: 300)

today = Date.today
days_of_week = %w[Monday Monday Tuesday Tuesday Wednesday Wednesday Thursday Thursday Friday Friday]

MenuItem.all.each do |menu_item|
  menu_item.schedule_availability(begin_date: today.strftime("%Y-%m-%d"),
                                  end_date: (today + 60).strftime("%Y-%m-%d"),
                                  day_of_week: days_of_week[menu_items.index(menu_item)])
end

