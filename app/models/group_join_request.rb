class GroupJoinRequest < ApplicationRecord
  # アソシエーション
  belongs_to :user
  belongs_to :group
end
