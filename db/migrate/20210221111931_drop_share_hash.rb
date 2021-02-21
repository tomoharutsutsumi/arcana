class DropShareHash < ActiveRecord::Migration[5.2]
  def change
    drop_table :share_hashes
  end
end
