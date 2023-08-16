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

    if @params[:order_by] == 'price'
      products = products.order(price: :asc)
    elsif @params[:order_by] == '-price' 
      products = products.order(price: :desc)
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

      if ['price', '-price'].include?(params[:order_by])
        validated_params[:order_by] = params[:order_by]
      end
  
      validated_params
    end
end
