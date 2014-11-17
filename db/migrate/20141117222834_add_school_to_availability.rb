class AddSchoolToAvailability < ActiveRecord::Migration
  def change
    add_reference :availabilities, :school, index: true
  end
end
