class AddPriorityToTurbolyapps < ActiveRecord::Migration[6.0]
  def change
    add_column :turbolyapps, :priority, :string
  end
end
