class AddUserIdToTurbolyapps < ActiveRecord::Migration[6.0]
  def change
    add_column :turbolyapps, :user_id, :integer
  end
end
