require 'csv'
require 'nkf'

column_names = %w(id 名前 支払い方法 購入金額 対応状況 受注日)

csv_str = CSV.generate do |csv|
  csv << column_names
  @json_order_list.each do |order|
    csv << [
    order.id,
    order.user.family_name + order.user.first_name,
    order.payment_info,
    order.price,
    order.order_status,
    order.created_at.strftime("%Y-%m-%d %H:%M:%S")
    ]
  end
end

NKF::nkf('--sjis -Lw', csv_str)