require 'csv'
require 'roo'
require 'nkf'
class Product < ActiveRecord::Base
  has_many :product_colors
  has_many :colors, through: :product_colors
  belongs_to :category
  has_many :images
  has_many :orders, through: :order_product_info
  has_many :order_product_infos
  has_many :carts
  has_one :ranking

  #商品名
  validates :name,:comment,
    presence: { message: 'は必須です' }
  #価格,在庫
  validates :price, :stocks,:size,:count,:status,
    presence: { message: 'は必須です'},
    numericality: { :only_integer => true , message: 'は必須です'}


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

end