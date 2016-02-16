class User < ActiveRecord::Base
  has_one :order, :dependent => :destroy
  belongs_to :city
  has_many :user_names

  accepts_nested_attributes_for :order
  accepts_nested_attributes_for :user_names
  #emailのバリデーション
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: {message: 'は必須です'},
                    length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX }

  #phoneのバリデーション
  validates :phone, presence:  { message: 'は必須です' },
                    length: { in: 10..15 , message: 'は10桁から15桁です。'},
                    numericality: {only_integer: true, message: 'は半角数字のみ入力できます。'}

  #postal_codeのバリデーション
  validates :postal_code, presence: { message: 'は必須です' },
                          numericality: {only_integer: true, :message => "は半角数字のみ入力できます" },
                          length: {maximum: 9,wrong_length: 'の桁数が違います。'}

  #cityのバリデーション
  validates :city, presence: { message: 'は必須です' },
                   exclusion: { in: %w({ }  . [ ] ) }

  #addressのバリデーション
  validates :address, presence: { message: 'は必須です' },
                      exclusion: { in: %w({ }  . [ ] ) }


 # validates_confirmation_of :email


  #validates :email, presence: { message: 'は必須です' }

  #validates :email_confirmation, presence: { message: 'は必須です' }
  #正規表現修正
  #validates :phone,:postal_code,
  #numericality: { only_integer: true , :message => "は半角数字のみ入力できます" },
end
