class AddTypeToAdvertisements < ActiveRecord::Migration[5.2]
  def change
    add_column :advertisements, :type, :string
  end
end
