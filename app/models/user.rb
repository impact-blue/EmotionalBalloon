class User < ActiveRecord::Base
  has_one :order, :dependent => :destroy
  belongs_to :city

  accepts_nested_attributes_for :order


 # validates_confirmation_of :email

  #姓名
  #validates :first_name,:first_name_kana,:last_name,:last_name_kana ,:address,:address2,
  #presence: { message: 'は必須です' }

  #validates :email, presence: { message: 'は必須です' }

#  validates :email_confirmation, presence: { message: 'は必須です' }
  #正規表現修正
 # validates :phone,:postal_code,
  #numericality: { only_integer: true , :message => "は半角数字のみ入力できます" },
  #presence: { message: 'は必須です' }
end
