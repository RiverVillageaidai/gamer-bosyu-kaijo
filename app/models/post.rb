class Post < ApplicationRecord

  # 投稿画像
  has_one_attached :image

  # アソシエーション
  belongs_to :user

  # バリデーション
  validates :title, presence: true 
  validates :body, presence: true,  length: { maximum: 6000 }
  validates :image, presence: true

  # 投稿画像用
  def get_image(width, height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
      image.variant(resize_to_limit: [width, height]).processed
  end

end
