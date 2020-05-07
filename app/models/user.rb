class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:facebook, :google_oauth2]

  validates :nickname, :birth_year_id, :birth_month_id, :birth_day_id, presence: true
  has_one :buyer
  has_one :phone
  has_one :phone
  has_one :address
  has_many :buyed_products, foreign_key: "buyer_id", class_name: "Products"
  has_many :saling_products, foreign_key: "saler_id", class_name: "Product"
  has_many :sold_products, foreign_key: "saler_id", class_name: "Product"
  has_many :sns_credentials
  
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
  format: { with: VALID_EMAIL_REGEX }
  validates :password, presence: true, length: { minimum: 7 }
  validates :first_name, :last_name, presence: true,
  format: {
    with: /\A[一-龥ぁ-ん]/,
    message: "全角のみで入力して下さい"
  }
  validates :first_name_kana, :last_name_kana, presence: true,
  format: {
    with: /\A[\p{katakana}　ー－&&[^ -~｡-ﾟ]]+\z/,
    message: "全角カタカナのみで入力して下さい"
  }
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :birth_year
  belongs_to_active_hash :birth_month
  belongs_to_active_hash :birth_day

  def self.from_omniauth(auth)
    sns = SnsCredential.where(provider: auth.provider, uid: auth.uid).first_or_create
    # sns認証したことがあればアソシエーションで取得
    # 無ければemailでユーザー検索して取得orビルド(保存はしない)
    user = sns.user || User.where(email: auth.info.email).first_or_initialize(
      nickname: auth.info.name,
        email: auth.info.email
    )
    # userが登録済みの場合はそのままログインの処理へ行くので、ここでsnsのuser_idを更新しておく
    if user.persisted?
      sns.user = user
      sns.save
    end
    { user: user, sns: sns }
  end
end

