class OrderDeliveryName < ActiveRecord::Base
  belongs_to :order

  accepts_nested_attributes_for :order

  validates :order_id, presence: true
  validates :order_family_name, presence: { message: 'は必須です' },
                               exclusion: { in: %w({ }  . [ ] ) }

  validates :order_first_name, presence: { message: 'は必須です' },
                              exclusion: { in: %w({ }  . [ ] ) }


end
