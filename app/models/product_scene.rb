class ProductScene < ActiveRecord::Base
  belongs_to :product
  belongs_to :scene

    validates :status, presence: true,
    numericality: {only_integer: true, message: 'は半角数字のみ入力できます。'}
end
