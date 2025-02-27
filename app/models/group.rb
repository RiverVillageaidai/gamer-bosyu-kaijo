class Group < ApplicationRecord
  # アソシエーション
  has_many :group_members,dependent: :destroy
  has_many :users, through: :group_members
  has_many :group_join_requests, dependent: :destroy
  belongs_to :owner, class_name: "User"  #オーナーIDを元にユーザー名表示用

  # バリデーション
  validates :name, presence: true

  # グループ画像
  has_one_attached :group_image, dependent: :purge_later

  # グループ画像用
  def get_group_image(width, height)
    unless group_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      group_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    group_image.variant(resize_to_fill: [width, height]).processed
  end

  # グループに所属してるか確認
  def group_member?(user)
    group_members.exists?(user_id: user.id)
  end

  # グループ検索用メソッド---------------------------------------------------------------------------
  def self.search_for(query, method) #self →Group自体をさしている

    if method == 'perfect' #検索方法が'perfect'（完全一致）の場合に実行
      Group.where(name: query).order(created_at: :desc) #nameカラムがqueryと完全に一致するレコードを検索
  
    elsif method == 'forward' #検索方法が'forward'（前方一致）の場合に実行
      Group.where('name LIKE ?', query+'%').order(created_at: :desc) #nameカラムがqueryで始まるレコードを検索
  
    elsif method == 'backward' #検索方法が'backward'（後方一致）の場合に実行
      Group.where('name LIKE ?', '%'+query).order(created_at: :desc) #nameカラムがqueryで終わるレコードを検索
  
    else #上記以外の場合、部分一致の検索処理を実行
      Group.where('name LIKE ?', '%'+query+'%').order(created_at: :desc) #nameカラムがqueryを含むレコードを検索
    end
  end

end
