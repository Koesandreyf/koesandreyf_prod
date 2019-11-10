class AddFieldsToTurbolyapps < ActiveRecord::Migration[6.0]
  def change
    add_column :turbolyapps, :date, :date
  end
end
