class Category < ActiveRecord::Base
  has_many :category_children

  validates :name,  presence: { message: 'は必須です' }
end
