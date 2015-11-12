class API < Grape::API
  format :json
  formatter :json, Grape::Formatter::Jbuilder

  get '/', jbuilder:'article/index' do
    @product = Product.all
  end
end