class GroupMember < ApplicationRecord
  #アソシエーション
  belongs_to :user
  belongs_to :group

end
