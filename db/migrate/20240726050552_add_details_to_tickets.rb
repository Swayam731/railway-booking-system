class AddDetailsToTickets < ActiveRecord::Migration[7.1]
  def change
    add_column :tickets, :number_of_passenger, :integer
    add_column :tickets, :source, :string
    add_column :tickets, :destination, :string
  end
end
