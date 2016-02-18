module TopHelper

def ranking

 @product_ranking = Product.all
 render :json  => @product_ranking

end


end
