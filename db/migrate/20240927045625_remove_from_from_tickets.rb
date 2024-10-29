class RemoveFromFromTickets < ActiveRecord::Migration[7.1]
  def change
    remove_column :tickets, :from, :string
  end
end
