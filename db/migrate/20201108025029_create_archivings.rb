class CreateArchivings < ActiveRecord::Migration[5.2]
  def change
    create_table :archivings do |t|
      t.references :user, foreign_key: true
      t.references :archived_list, foreign_key: true

      t.timestamps
    end
    add_index :archivings, [:user_id, :archived_list_id], unique: true
  end
end
