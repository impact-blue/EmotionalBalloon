class User < ActiveRecord::Base
  has_one :order
  has_many :user_names

  accepts_nested_attributes_for :order
  accepts_nested_attributes_for :user_names
  #emailのバリデーション
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: {message: 'は必須です'},
                    length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX }

  #customer_phoneのバリデーション
  validates :customer_phone, presence:  { message: 'は必須です' },
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


  def self.repeat_search(order)
    #下記のカラムが2つ以上のユーザーをリピート判定
    user = User.where(
      "name = ? or customer_phone = ? or email = ? or address = ?",
      order.user.name ,order.user.customer_phone ,order.user.email, order.user.address)

    repeat_user = []
    repeat_count = 1
    repeat = Hash.new(:repeat_user_id => 0,:repeat_count => 0)
    user.each do |u|
      count = 0
        if u.name == order.user.name
          count += 1
        end
        if u.customer_phone == order.user.customer_phone
          count += 1
        end
        if u.email == order.user.email
          count += 1
        end
        if u.address == order.user.address
          count += 1
        end
        if count >= 2
          repeat_count += 1
          repeat_user << u
        end
    end
    repeat[:repeat_count] = repeat_count
    if repeat_user.first.present?
       repeat[:first_user_id] = repeat_user.first.id
    else
      repeat[:first_user_id] = "null"
    end
    #user_idとrepeat_count
    return repeat
  end


end
