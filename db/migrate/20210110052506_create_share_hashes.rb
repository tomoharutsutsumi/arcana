class CreateShareHashes < ActiveRecord::Migration[5.2]
  def change
    create_table :share_hashes do |t|
      t.references :list, foreign_key: true
      t.string :hash_string, null: false

      t.timestamps
    end

    add_index :share_hashes, :hash_string, unique: true
  end
end
