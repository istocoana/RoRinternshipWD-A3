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

    products = apply_sort(products)

    products
    end

    private

    def apply_sort(products)
      if @params[:sort_by] == 'price'
        if @params[:sort_order] == 'asc'
          products = products.order(price: :asc)
        elsif @params[:sort_order] == 'desc'
          products = products.order(price: :desc)
        end
      end
    products
    end

    def validate_params(params)
      validated_params = {}
  
      if params[:category].present? && params[:category] != 'Category'
        validated_params[:category] = params[:category]
      end
  
      if params[:vegetarian].present? && ['true', 'false'].include?(params[:vegetarian])
        validated_params[:vegetarian] = params[:vegetarian] == 'true'
      end
  
      if params[:min_price].present? && params[:max_price].present?
        min_price = params[:min_price].to_f
        max_price = params[:max_price].to_f
        validated_params[:min_price] = min_price
        validated_params[:max_price] = max_price
      end
  
      if params[:sort_by] == 'price' && ['asc', 'desc'].include?(params[:sort_order])
        validated_params[:sort_by] = params[:sort_by]
        validated_params[:sort_order] = params[:sort_order]
      end
  
      validated_params
    end
end
