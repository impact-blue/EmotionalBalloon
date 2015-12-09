class User < ActiveRecord::Base
  has_many :orders
  belongs_to :city

  validates_confirmation_of :email

  #姓名
  validates :first_name,:first_name_kana,:last_name,:last_name_kana ,:address,:address2,
  presence: { message: 'は必須です' }

  validates :email, presence: { message: 'は必須です' }

  validates :email_confirmation, presence: { message: 'は必須です' }
#正規表現修正
  validates :phone,
  :format => { :with => /[0-9]/, :message => "半角数字のみ入力できます" },
  presence: { message: 'は必須です' }
end
