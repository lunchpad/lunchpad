# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Ability.delete_all
Account.delete_all
AccountOwnership.delete_all
AvailableMenuItem.delete_all
MenuItem.delete_all
OffDay.delete_all
OrderedItem.delete_all
Order.delete_all
Role.delete_all
School.delete_all
Vendor.delete_all
User.delete_all


super_admin = User.create(email: 'email@gmail.com',
                          password: 'password',
                          password_confirmation: 'password',
                          first_name: 'Lunch',
                          last_name: 'Pad')


hogwarts = School.create(name: 'Hogwarts',
                       description: 'School of Witchcraft and Wizardry',
                       motto: 'Never Tickle a Sleeping Dragon',
                       phone: Faker::PhoneNumber.phone_number,
                       address: 'Somewhere in Scotland',
                       section_name: "House",
                       section_titles: "Gryffindor Hufflepuff Ravenclaw Slytherin")

OffDay.create(name: "Christmas Day", date: '2014-12-25', school: hogwarts)
OffDay.create(name: "MLK Jr. Birthday", date: '2015-01-19', school: hogwarts)
OffDay.create(name: "Washington's Birthday", date: '2015-02-16', school: hogwarts)
OffDay.create(name: "Memorial Day", date: '2015-05-25', school: hogwarts)

section = "Gryffindor"

account = Account.create(school: hogwarts,
                         balance: 0,
                         name: 'Neville Longbottom',
                         section: section)

User.create(email: 'deedeelavinder@gmail.com',
            first_name: 'DeeDee',
            last_name: 'Lavinder',
            password: 'password',
            password_confirmation: 'password')

User.create(email: 'nickpassarella@gmail.com',
            first_name: 'Nick',
            last_name: 'Passarella',
            password: 'password',
            password_confirmation: 'password')

User.create(email: 'kheang@gmail.com',
            first_name: 'Kheang',
            last_name: 'Lim',
            password: 'password',
            password_confirmation: 'password')


# super_admin.add_role :admin, hogwarts


User.all.each do |user |
  user.add_role :admin, hogwarts
  AccountOwnership.create(user: user, account: account)
end



vendor_tbi = Vendor.create(name: "Three Broomsticks",
                           email: 'tbi@gmail.com',
                           phone_number: '555-555-5555',
                           school: hogwarts)

vendor_hc = Vendor.create(name: "Hagrid's Cookery",
                          email: 'hc@gmail.com',
                          phone_number: '888-888-8888',
                          school: hogwarts)

vendor_lc = Vendor.create(name: "Leaky Cauldron",
                           email: 'lc@gmail.com',
                           phone_number: '444-444-4444',
                           school: hogwarts)

menu_items = []

menu_items << MenuItem.create(vendor: vendor_tbi,
                              name: "Shepherd's Pie",
                              description: 'meat pie with a crust of mashed potato',
                              price: 400)

menu_items << MenuItem.create(vendor: vendor_tbi,
                              name: 'Cornish Pasties',
                              description: 'a pastry case with variable fillings, usually beef and vegetables',
                              price: 400)

menu_items << MenuItem.create(vendor: vendor_tbi,
                              name: 'Salad',
                              description: 'from the garden',
                              price: 300)

menu_items << MenuItem.create(vendor: vendor_tbi,
                              name: 'Smoked Chicken Platter',
                              description: 'open fire smoked and roasted',
                              price: 600)

menu_items << MenuItem.create(vendor: vendor_hc,
                              name: 'Alleged Beef Casserole',
                              description: 'not veggie',
                              price: 400)

menu_items << MenuItem.create(vendor: vendor_hc,
                              name: 'Rock Cakes',
                              description: 'a small, hard fruit cake with a rough surface resembling a rock',
                              price: 300)

menu_items << MenuItem.create(vendor: vendor_hc,
                              name: 'Stoat Sandwiches',
                              description: 'wheat with the meat of a stoat',
                              price: 400)

menu_items << MenuItem.create(vendor: vendor_hc,
                              name: 'Cabbage',
                              description: 'garden fresh-ish',
                              price: 200)

menu_items << MenuItem.create(vendor: vendor_lc,
                              name: 'Mince Pie',
                              description: 'fruit-based mincemeat sweet pie',
                              price: 300)

menu_items << MenuItem.create(vendor: vendor_lc,
                              name: 'Fish and Chips',
                              description: 'battered and deep-fried haddock and chips',
                              price: 300)

menu_items << MenuItem.create(vendor: vendor_lc,
                              name: 'Bangers and Mash',
                              description: 'mashed potatoes and sausages',
                              price: 400)

days_of_week = %w[Monday Monday Tuesday Tuesday Wednesday Wednesday Thursday Thursday Thursday Friday Friday]

MenuItem.all.each do |menu_item|
  menu_item.schedule_availability(Date.today.strftime("%Y-%m-%d"),
                                  ("2015-06-10"),
                                  days_of_week[menu_items.index(menu_item)])
end

