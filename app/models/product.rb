require 'csv'
require 'roo'
require 'nkf'
class Product < ActiveRecord::Base
  #has_many :product_colors
  #has_many :colors, through: :product_colors
  belongs_to :category
  has_many :images
  has_many :orders, through: :order_product_info
  has_many :order_product_infos
  has_one  :ranking
  has_many   :sub_color, class_name: "Product", foreign_key: "main_color_id"
  belongs_to :main_color,class_name: "Product"

  #商品名
  validates :name,:comment,
    presence: { message: 'は必須です' }
  #価格,在庫
  validates :price, :stocks,:size,:count,:status,:category_id,
    presence: { message: 'は必須です'},
    numericality: { :only_integer => true , message: 'は半角数字で入力してください'}



  def self.import(file)
    spreadsheet = open_spreadsheet(file)
    header = ["id","name","price","stocks","comment","keyword","size","count","status","created_at"]

    (2..spreadsheet.last_row).each do |i|
      # {カラム名 => 値, ...} のハッシュを作成する
      row = Hash[[header, spreadsheet.row(i)].transpose]

      # IDが見つかれば、レコードを呼び出し、見つかれなければ、新しく作成
      product = find_by(id: row["id"]) || new
      # CSVからデータを取得し、設定する
      product.attributes = row.to_hash.slice(*updatable_attributes)
      # 保存する、失敗はロールバック
      product.save!
    end
  end

  def self.open_spreadsheet(file)
    case File.extname(file.original_filename)
    when '.csv'  then Roo::CSV.new(file.path, csv_options: {encoding:'Shift_JIS:UTF-8'})
    when '.xls'  then Roo::Excel.new(file.path,  nil, :ignore)
    when '.xlsx' then Roo::Excelx.new(file.path, nil, :ignore)
    when '.ods'  then Roo::OpenOffice.new(file.path, nil, :ignore)
    else raise "Unknown file type: #{file.original_filename}"
    end
  end

  # 更新を許可するカラムを定義
  def self.updatable_attributes
    ["name", "price","stocks","comment","keyword","size","status","count","category_id"]
  end


  def self.get_list_all_page(page,per)
    return self.all.page(page).per(per).includes(:images)
  end

  def self.get_list_public(page,per)
    return self.get_list_pages_by_status(1,page,per)
  end

  def self.get_list_secret(page,per)
    return self.get_list_pages_by_status(0,page,per)
  end

  def self.get_list_pages_by_status(status,page,per)
    return self.where(status: status).page(page).per(per).includes(:images)
  end

  def self.get_list_no_stocks(page,per)
    return self.where(stocks: 0).page(page).per(per).includes(:images)
  end

end