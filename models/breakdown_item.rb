
class BreakdownItem
    attr_accessor :productId, :name, :unitPrice, :total, :quantity

    def initialize(opts = {})
        build(opts[:item]) if opts[:item]
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
