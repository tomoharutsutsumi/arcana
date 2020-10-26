class AddColumnTelToRestaurnant < ActiveRecord::Migration[5.2]
  def change
    add_column :restaurants, :tel, :string
  end
end
