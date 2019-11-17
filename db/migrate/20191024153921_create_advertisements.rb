class CreateAdvertisements < ActiveRecord::Migration[5.2]
  def change
    create_table :advertisements do |t|
      t.string :name
      t.string :image
      t.text :text
      t.string :state
      t.string :type
      t.belongs_to :user
      t.timestamps
    end
  end
end
