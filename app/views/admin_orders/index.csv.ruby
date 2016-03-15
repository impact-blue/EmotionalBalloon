require 'csv'
require 'nkf'

column_names = %w(注文ID ユーザーID 初回ユーザーID 購入回数 名前 電話番号(注文者) 電話番号（配送先） メールアドレス(注文者) 郵便番号（注文者） 住所（注文者） 郵便番号（配送先） 住所（配送先） 支払い方法 購入金額 購入商品番号 対応状況 受注日)
@json_order_list = Order.includes(:user,user: :user_names).all
csv_str = CSV.generate do |csv|
  csv << column_names
  @json_order_list.each do |order|
    csv << [
    order.id,
    order.user.id,
    order.user.repeat_user_id,
    order.user.repeat_count,
    order.user.user_names[0].user_family_name + order.user.user_names[0].user_first_name,
    order.user.phone,
    order.phone,
    order.user.email,
    order.user.postal_code,
    order.user.city + order.user.address,
    order.postal_code,
    order.city + order.delivery_address,
    order.payment_info,
    order.price,
    order.order_product_infos.ids,
    order.order_status,
    order.created_at.strftime("%Y-%m-%d %H:%M:%S")
    ]
  end
end

NKF::nkf('--sjis -Lw', csv_str)