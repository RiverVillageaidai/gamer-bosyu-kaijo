class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  #ログイン制限（active_for_authentication? : deviseの機能）
  
  def active_for_authentication?
    super && (is_active == true)#true の場合 → ユーザーはログインできる  nill(空白の時もログインできない。)　これがバグの原因新規登録時にTRUEを設定
  end

  # プロフィール画像
  has_one_attached :profile_image

   # アソシエーション
   has_many :posts, dependent: :destroy

  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
  end

end
