class RenameAvailabilitiesToAvailableMenuItems < ActiveRecord::Migration
  def change
    rename_table :availabilities, :available_menu_items
  end
end
