class LineItem < Sequel::Model(:sales_line_item)
    many_to_one :order, key: :order_id
    many_to_one :product, key: :product_id
end
