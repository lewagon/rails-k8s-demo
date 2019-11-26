class AddAuthorToMessages < ActiveRecord::Migration[6.0]
  def change
    add_column :messages, :author, :string
  end
end
