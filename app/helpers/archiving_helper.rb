module ArchivingHelper
  def find_archiving_lists_with_user(current_user, user)
    lists = []
    Archiving.where(user: user).each do |a|
      if a.archived_list.user == current_user
        lists << a.archived_list
      end
    end
    lists
  end
end