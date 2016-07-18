
class BreakdownItem
    attr_reader :productId, :name, :unitPrice, :total, :quantity

    def initialize(item)
        build item
    end

    private

    def build(item)
        @productId = item['product_id']
        product = Product[@productId]
        @name = product.nombre
        @unitPrice = product.precio_venta
        @quantity = item['quantity']
        @total = @unitPrice * @quantity
    end
end
