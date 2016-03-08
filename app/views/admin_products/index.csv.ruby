require 'csv'
require 'nkf'

column_names = %w(id 名前 価格 在庫 コメント 検索キーワード サイズ 購入回数 公開/非公開 作成日)

      if params[:status] == "all"
        @csv_products = Product.all.page(params[:page]).per(@page).order("created_at ASC")
      elsif params[:status] == "publuc"
        @csv_products = Product.where(stutus: 1).page(params[:page]).per(@page).order("created_at ASC")
      elsif params[:status] == "secret"
        @csv_products = Product.where(status: 0).page(params[:page]).per(@page).order("created_at asc")
      elsif params[:status] == "none"
        @csv_products = Product.where(stocks: 0).page(params[:page]).per(@page).order("created_at asc")
      end

      if params[:id].present?
        @csv_products = Product.where(id: params[:id].split(" ").map(&:to_i)).order("created_at asc")
      end

csv_str = CSV.generate do |csv|
  csv << column_names
  @csv_products.each do |product|
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