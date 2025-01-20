class Like < ApplicationRecord
  # アソシエーション
  belongs_to :user
  belongs_to :post

  #バリデーション
  validates :user_id, uniqueness: {scope: :post_id} #user.id とpost.idのペアが重複していないか
end
