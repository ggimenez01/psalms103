class FrontPage::ProductsController < FrontPageController
  def show
    @product = Product.find(params[:id])
  end

  def index
    @products = Product.page(params[:page]).per(10)
  end
  def category
    @category = Category.find(params[:category_id])
    @products = @category.products.page(params[:page]).per(10)
  end
  
end
