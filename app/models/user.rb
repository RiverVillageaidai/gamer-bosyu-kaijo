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

  # アソシエーション-----------------------------------------------------------------------------------------------------
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  # フォローしている関係
  has_many :active_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  # フォローしている一覧
  has_many :followings, through: :active_relationships, source: :followed
 
  # フォローされている関係
  has_many :passive_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  #フォローされている一覧
  has_many :followers, through: :passive_relationships, source: :follower

  # バリデーション------------------------------------------------------------------------------------------------------
  validates :name, presence: true 
  validates :email, presence: true 
  validates :introduction, length: { maximum: 500 }

  # プロフィール画像用メソッド------------------------------------------------------------------------------------------
  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
  end

  # ユーザー検索用メソッド---------------------------------------------------------------------------
  def self.search_for(query, method) #self →User自体をさしている

    if method == 'perfect' #検索方法が'perfect'（完全一致）の場合に実行
      User.where(name: query).order(created_at: :desc) #nameカラムがqueryと完全に一致するレコードを検索
  
    elsif method == 'forward' #検索方法が'forward'（前方一致）の場合に実行
      User.where('name LIKE ?', query+'%').order(created_at: :desc) #nameカラムがqueryで始まるレコードを検索
  
    elsif method == 'backward' #検索方法が'backward'（後方一致）の場合に実行
      User.where('name LIKE ?', '%'+query).order(created_at: :desc) #nameカラムがqueryで終わるレコードを検索
  
    else #上記以外の場合、部分一致の検索処理を実行
      User.where('name LIKE ?', '%'+query+'%').order(created_at: :desc) #nameカラムがqueryを含むレコードを検索
    end
  end

  #フォロー機能関連--------------------------------------------------------------------------------------------
  # フォローするメソッド
  def follow(user)
    active_relationships.create(followed_id: user.id)
  end

  # フォロー解除メソッド
  def unfollow(user)
    active_relationships.find_by(followed_id: user.id).destroy
  end

  # フォローしているか確認メソッド
  def following?(user)
    followings.include?(user)
  end

end
