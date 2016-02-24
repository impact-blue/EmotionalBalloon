class Scene < ActiveRecord::Base
  has_many :product_scenes
  has_many :products, through: :product_scenes
  has_many :orders


  validates :name_en,
    presence: true,
    format: { with: /\A[a-zA-Z]+\z/}

  validates :name_ja,
    presence: true

  validates :status, presence: true,
    numericality: {only_integer: true, message: 'は半角数字のみ入力できます。'}
end
