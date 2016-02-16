class OrderDeliveryName < ActiveRecord::Base
  belongs_to :order, foreign_key: 'order_id'



  validates :order_id, presence: true
  validates :order_family_name, presence: { message: 'は必須です' },
                               exclusion: { in: %w({ }  . [ ] ) }

  validates :order_first_name, presence: { message: 'は必須です' },
                              exclusion: { in: %w({ }  . [ ] ) }


end
