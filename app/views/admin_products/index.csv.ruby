require 'csv'
require 'nkf'

column_names = %w(id 名前 価格 在庫 コメント 購入回数 公開/非公開 作成日)

csv_str = CSV.generate do |csv|
  csv << column_names
  @json_products.each do |product|
    csv << [
    product.id,
    product.name,
    product.price,
    product.stocks,
    product.comment,
    product.count,
    product.status,
    product.created_at.strftime("%Y-%m-%d %H:%M:%S")
    ]
  end
end

NKF::nkf('--sjis -Lw', csv_str)