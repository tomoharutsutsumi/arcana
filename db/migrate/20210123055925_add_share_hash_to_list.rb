require 'securerandom'
class AddShareHashToList < ActiveRecord::Migration[5.2]
  def change
    add_column :lists, :share_hash, :string, null: false, default: ''

    List.all.find_each do |l|
      l.update(share_hash: Digest::SHA1.hexdigest(l.created_at.to_s))
    end

    add_index :lists, :share_hash, unique: true
  end
end
