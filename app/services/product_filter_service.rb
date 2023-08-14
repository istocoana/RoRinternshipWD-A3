class ProductFilterService
  def initialize(params)
    @params = validate_params(params)
  end
  

  def filter
    products = Product.all
    
    if @params[:category].present? && @params[:category].in?(Product.categories.keys)
      products = products.where(category: @params[:category])
    end
    
    if @params[:vegetarian].present? && @params[:vegetarian] != 'Vegetarian'
      is_vegetarian = @params[:vegetarian] == 'true'
      products = products.where(vegetarian: is_vegetarian)
    end

    if @params[:min_price].present? && @params[:max_price].present?
      min_price = @params[:min_price].to_f
      max_price = @params[:max_price].to_f
      products = products.where(price: min_price..max_price)
    end
    
    products
    end

    private

    def validate_params(params)
      validated_params = {}
  
      if params[:category].present? && params[:category] != 'Category'
        validated_params[:category] = params[:category]
      end
  
      if params[:vegetarian].present? && ['true', 'false'].include?(params[:vegetarian])
        validated_params[:vegetarian] = params[:vegetarian]
      end
  
      validated_params
    end
end
