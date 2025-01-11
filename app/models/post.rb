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

  # 投稿検索用 
  def self.search_for(query, method) #self →Post自体をさしている

    if method == 'perfect' #検索方法が'perfect'（完全一致）の場合に実行
      Post.where(title: query).order(created_at: :desc) #titleカラムがqueryと完全に一致するレコードを検索

    elsif method == 'forward' #検索方法が'forward'（前方一致）の場合に実行
      Post.where('title LIKE ?', query+'%').order(created_at: :desc) #titleカラムがqueryで始まるレコードを検索

    elsif method == 'backward' #検索方法が'backward'（後方一致）の場合に実行
      Post.where('title LIKE ?', '%'+query).order(created_at: :desc) #titleカラムがqueryで終わるレコードを検索

    else #上記以外の場合、部分一致の検索処理を実行
      Post.where('title LIKE ?', '%'+query+'%').order(created_at: :desc) #titleカラムがqueryを含むレコードを検索
    end
  end



end
