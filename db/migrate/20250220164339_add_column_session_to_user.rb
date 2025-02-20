class AddColumnSessionToUser < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :session, :uuid
  end
end
