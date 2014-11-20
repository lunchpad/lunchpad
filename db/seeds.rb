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

vendor_ht = Vendor.create(name: 'Harris Teeter',
              email: 'email@gmail.com',
              phone_number: '555-555-5555',
              school: willow)

menu_item_1 = MenuItem.create(vendor: vendor_ht,
                              name: 'Pizza',
                              description: 'cheese',
                              price: 3)


menu_item_2 = MenuItem.create(vendor: vendor_ht,
                              name: 'Burger',
                              description: 'veggie',
                              price: 4)

menu_item_3 = MenuItem.create(vendor: vendor_ht,
                              name: 'Salad',
                              description: 'garden',
                              price: 5)

available_item_1 = AvailableMenuItem.create(date: Date.parse('2014-11-17'),
                                            menu_item: menu_item_1,
                                            school: willow)


available_item_2 = AvailableMenuItem.create(date: Date.parse('2014-11-18'),
                                            menu_item: menu_item_2,
                                            school: willow)


available_item_3 = AvailableMenuItem.create(date: Date.parse('2014-11-19'),
                                            menu_item: menu_item_3,
                                            school: willow)

