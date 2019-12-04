# frozen_string_literal: true
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
      Spree::ProductProperty.joins(:property)
        .where(:product_id => self.product.id)
        .where(:spree_properties => {:name => 'brand'})
        .first&.value
    end

    def total_count_on_hand
      stock_items.sum(:count_on_hand)
    end

    def google_base_image_size
      :large
    end

    def google_base_price
      "#{price} #{cost_currency}"
    end
  end
end
