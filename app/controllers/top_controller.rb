class TopController < ApplicationController
  before_action :set_json_categories

  def index
    #公開商品のみ

    #タイムゾーン取得
    current_day = Time.zone.now

    #30日間に購入された商品情報を取得
    last_30days_buy = OrderProductInfo.includes(:product).select("product_id,count").where('created_at >= ? ',Time.zone.now - 30.day).order("product_id ASC")

    product_ids = []  #購入された商品の番号の配列
          count = []  #ランキングをカウントするデータの配列
          sum   = []  #30日間の購入情報から、商品IDとその個数だけ取り出した情報

    last_30days_buy.each do |p|
        if  p.product.status == 1
        product_ids << p.product_id
        end
    end

    #重複のないproduct_idよりハッシュを追加(countのid部分)
    product_ids.uniq.each do |p|
        data = Hash.new(:id => 0,:count => 0)
        data[:id] = p
        data[:count] = 0
        count << data
    end

    #取り出した情報をまとめる（sumを求める）
    last_30days_buy.each_with_index do |p,i|
        data = Hash.new(:id => 0,:count => 0)
        data[:id] = p.product_id
        data[:count] = p.count
        sum << data
    end

    #countのデータを求める
    sum.each do |s|
      count.each do |c|
        if s[:id] == c[:id]
          c[:count] += s[:count]
        end
      end
    end

    count_sort = count.sort_by!{|c| c[:count] }.reverse.slice(0..4) #countを購入回数のの多い順に並べ替え（最大20個）
    product_id_only_5 =[] #ランキング5位をソートしてidを抽出
    count_sort.each do |c|
      product_id_only_5 << c[:id]
    end
    if Product.select(:id).count >= 5
       @json_ranking_products  = Product.includes(:images).where(id: product_id_only_5).order("field(id, #{product_id_only_5.join(',')})")
    end

  end

end