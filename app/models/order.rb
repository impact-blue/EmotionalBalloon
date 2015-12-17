class Order < ActiveRecord::Base
  belongs_to :product
  belongs_to :payment #未
  belongs_to :user, foreign_key: 'user_id'
  belongs_to :city
  belongs_to :scene

  enum order_status: { unconfirmed: 10, process: 20 , complete: 30 }

  #姓名
  validates :delivery_address,:delivery_address2,
  presence: { message: 'は必須です' }

end
