class Group < ApplicationRecord
  # アソシエーション
  has_many :group_members,dependent: :destroy
  has_many :users, through: :group_members

  # バリデーション
  validates :name, presence: true

  # グループ画像
  has_one_attached :group_image

  # グループ画像用
  def get_group_image(width, height)
    unless group_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      group_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    group_image.variant(resize_to_fill: [width, height]).processed
  end
end
