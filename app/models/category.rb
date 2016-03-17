class Category < ActiveRecord::Base
  has_many :products

  validates :name_en,:name_ja ,presence:{ message: 'は必須です'}

  validates :genre, presence: { message: 'は必須です'}

  validates :status , presence: { message: 'は必須です'},
                      length: { :is => 1, :wrong_length => "1文字以外認めません" },
                      numericality: {only_integer: true, message: 'は半角数字のみ入力できます'}
end
