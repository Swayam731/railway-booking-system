class RemoveToFromTickets < ActiveRecord::Migration[7.1]
  def change
    remove_column :tickets, :to, :string
  end
end
