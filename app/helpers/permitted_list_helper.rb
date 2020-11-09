module PermittedListHelper
  def is_archived?(list)
    list.instance_of?(ArchivedList)
  end
end