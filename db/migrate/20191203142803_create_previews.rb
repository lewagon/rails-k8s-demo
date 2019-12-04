class CreatePreviews < ActiveRecord::Migration[6.0]
  def change
    create_table :previews do |t|
      t.string :title
      t.string :url
      t.string :image_url
      t.text :description
      t.references :message, null: false, foreign_key: true
      t.timestamps
    end
  end
end
