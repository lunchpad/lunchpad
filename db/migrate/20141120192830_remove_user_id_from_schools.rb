class RemoveUserIdFromSchools < ActiveRecord::Migration
  def change
    remove_column :schools, :user_id
  end
end
