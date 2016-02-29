class Chara < ActiveRecord::Base
  has_many :product_charas
  has_many :products, through: :product_charas

  validates :name_en,
    presence: true,
    format: { with: /\A[a-zA-Z]+\z/}

  validates :name_ja,
    presence: true

end
