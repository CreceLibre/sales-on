require 'securerandom'

class Order < Sequel::Model(:sales_order)
    one_to_many :line_items, key: :order_id

    def before_create
        self.uuid = SecureRandom.uuid
        self.total_items = line_items.length
        subtotal_taxed = 0
        subtotal_non_taxed = 0
        line_items.each do |item|
            if item.product.exento_iva
                subtotal_taxed += item.product.precio_venta
            else
                subtotal_non_taxed += item.product.precio_venta
            end
        end
        self.subtotal_taxed = subtotal_taxed
        self.subtotal_non_taxed = subtotal_non_taxed
        self.total = subtotal_taxed + subtotal_non_taxed
        super
    end
end
