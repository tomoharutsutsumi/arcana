class CoverError < ActiveRecord::Migration[5.2]
  def change
    ArchivedList.all.find_each do |l|
      if l.user_id == null
        l.update(user_id: 1)
      end
    end
  end
end
