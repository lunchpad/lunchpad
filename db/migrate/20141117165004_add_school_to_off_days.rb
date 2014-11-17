class AddSchoolToOffDays < ActiveRecord::Migration
  def change
    add_reference :off_days, :school, index: true
  end
end
