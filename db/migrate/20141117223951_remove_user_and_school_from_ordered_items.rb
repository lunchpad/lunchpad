class RemoveUserAndSchoolFromOrderedItems < ActiveRecord::Migration
  def change
    remove_column :ordered_items, :user_id
    remove_column :ordered_items, :school_id
  end
end
