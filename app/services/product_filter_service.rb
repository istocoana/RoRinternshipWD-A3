class ProductFilterService
  def initialize(params)
    @params = params
  end

  def filter
    products = Product.all
    products = products.where(category: @params[:category]) if @params[:category].present?
    products = products.where(vegetarian: @params[:vegetarian]) if @params[:vegetarian].present?
    products
  end
end
