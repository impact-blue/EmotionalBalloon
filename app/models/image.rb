class Image < ActiveRecord::Base
  belongs_to :product

  validates :product_id,presence: { message: 'は必須です'},
                        numericality: {only_integer: true, message: 'は半角数字のみ入力できます'}
  validates :image_content_type,
  inclusion: { :in => %w("image/jpg image/jpeg image/png image/x-citrix-png image/x-citrix-jpeg image/x-png image/pjpeg") , :message => 'はファイル形式が不正です'}
end
