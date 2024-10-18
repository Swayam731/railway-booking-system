class AddFareToTickets < ActiveRecord::Migration[7.1]
  def change
    add_column :tickets, :fare, :float
  end
end
