require 'csv'
require 'nkf'

column_names = %w(id 名前 価格 在庫 コメント 検索キーワード サイズ 購入回数 公開/非公開 作成日)

  @products = Product.all.order("created_at ASC")
csv_str = CSV.generate do |csv|
  csv << column_names
  @products.each do |product|
    csv << [
    product.id,
    product.name,
    product.price,
    product.stocks,
    product.comment,
    product.keyword,
    product.size,
    product.count,
    product.status,
    product.created_at.strftime("%Y-%m-%d %H:%M:%S")
    ]
  end
end

NKF::nkf('--sjis -Lw', csv_str)