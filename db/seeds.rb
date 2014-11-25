# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


Account.destroy_all
AccountOwnership.destroy_all
AvailableMenuItem.destroy_all
MenuItem.destroy_all
OffDay.destroy_all
OrderedItem.destroy_all
School.destroy_all
User.destroy_all
Vendor.destroy_all

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
                              price: 3)

menu_items << MenuItem.create(vendor: vendor_ht,
                              name: 'Burger',
                              description: 'veggie',
                              price: 4)

menu_items << MenuItem.create(vendor: vendor_cat,
                              name: 'Salad',
                              description: 'garden',
                              price: 5)

menu_items << MenuItem.create(vendor: vendor_cat,
                              name: 'California roll',
                              description: 'veggie',
                              price: 8)

menu_items << MenuItem.create(vendor: vendor_ht,
                              name: 'Chicken nuggets',
                              description: 'not veggie',
                              price: 4)

menu_items << MenuItem.create(vendor: vendor_ht,
                              name: 'Turkey sandwich',
                              description: 'wheat bread',
                              price: 6)

menu_items << MenuItem.create(vendor: vendor_cat,
                              name: 'Veggie wrap',
                              description: 'veggie',
                              price: 4)

menu_items << MenuItem.create(vendor: vendor_ht,
                              name: 'Ham sandwich',
                              description: 'wheat bread',
                              price: 4)

menu_items << MenuItem.create(vendor: vendor_cat,
                              name: 'Veggie wrap',
                              description: 'veggie',
                              price: 3)

menu_items << MenuItem.create(vendor: vendor_ht,
                              name: 'Ham sandwich',
                              description: 'wheat bread',
                              price: 3)

today = Date.today
days_of_week = %w[Monday Monday Tuesday Tuesday Wednesday Wednesday Thursday Thursday Friday Friday]

MenuItem.all.each do |menu_item|
  menu_item.schedule_availability(begin_date: today.strftime("%Y-%m-%d"),
                                  end_date: (today + 30).strftime("%Y-%m-%d"),
                                  day_of_week: days_of_week[menu_items.index(menu_item)])
end

