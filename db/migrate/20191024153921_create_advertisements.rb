class CreateAdvertisements < ActiveRecord::Migration[5.2]
  def change
    create_table :advertisements do |t|
      t.string :name
      t.text :text
      t.string :state
      t.belongs_to :user
      t.timestamps
    end
  end
end
