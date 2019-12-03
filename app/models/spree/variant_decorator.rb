module Spree
  Variant.class_eval do
    def google_base_condition
      'new'
    end

    def google_base_availability
      'in stock'
    end

    def google_base_description
      description
    end

    def google_base_brand
      # Taken from github.com/romul/spree-solr-search
      # app/models/spree/product_decorator.rb
      #
      pp = Spree::ProductProperty.joins(:property)
                                .where(:product_id => self.product.id)
                                .where(:spree_properties => {:name => 'brand'})
                                .first

      pp ? pp.value : nil
    end

    def total_count_on_hand
      stock_items.sum(:count_on_hand)
    end
  end
end