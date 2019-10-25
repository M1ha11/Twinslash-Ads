class CreateAdvertisements < ActiveRecord::Migration[5.2]
  def change
    create_table :advertisements do |t|
      t.text :text
      t.string :status
      t.string :type
      t.timestamps
    end
  end
end
