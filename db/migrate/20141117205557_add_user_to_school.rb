class AddUserToSchool < ActiveRecord::Migration
  def change
    add_reference :schools, :user, index: true
  end
end
