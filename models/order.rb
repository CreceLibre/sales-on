class Order < Sequel::Model(:sales_order)
    one_to_many :line_items, key: :order_id
end
