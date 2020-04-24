# frozen_string_literal: true

module Spree
  Variant.class_eval do
    def google_base_id
      Spree::Product.exists?(id) ? "Variant#{id}" : id
    end

    def google_base_condition
      'new'
    end

    def google_base_availability
      self.can_supply? ? 'in stock' : 'out of stock'
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
      "#{price_in(cost_currency).price.to_f} #{cost_currency}"
    end
  end
end
