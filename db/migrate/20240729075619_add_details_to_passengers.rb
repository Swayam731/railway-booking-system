class AddDetailsToPassengers < ActiveRecord::Migration[7.1]
  def change
    add_column :passengers, :name2, :string
    add_column :passengers, :age2, :integer
  end
end
