require 'csv'
require 'nkf'

column_names = %w(id 名前 郵便番号（注文者） 住所（注文者） メールアドレス 電話番号（注文者） 郵便番号（配送先） 住所（配送先） 電話番号 支払い方法 購入金額 対応状況 受注日)

csv_str = CSV.generate do |csv|
  csv << column_names
  @json_order_list.each do |order|
    csv << [
    order.id,
    order.user.user_names[0].user_family_name + order.user.user_names[0].user_first_name,
    order.user.postal_code,
    order.user.city + order.user.address,
    order.user.email,
    order.user.phone,
    order.postal_code,
    order.city + order.delivery_address,
    order.phone,
    order.payment_info,
    order.price,
    order.order_status,
    order.created_at.strftime("%Y-%m-%d %H:%M:%S")
    ]
  end
end

NKF::nkf('--sjis -Lw', csv_str)