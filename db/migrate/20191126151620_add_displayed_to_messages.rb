class AddDisplayedToMessages < ActiveRecord::Migration[6.0]
  def change
    add_column :messages, :displayed, :boolean, null: false, default: false
  end
end
