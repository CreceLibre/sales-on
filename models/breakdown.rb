
class Breakdown
    attr_reader :items, :subtotal, :total

    def initialize(items)
        @items = items
        build
    end

    private

    def build
        # TODO: discount should be added here
        @items = @items.map { |i| add_item_data(i) }
        @subtotal = add_subtotal_data @items
        @total = add_total_data @items
    end

    def add_item_data(item)
        product = Product[item['product_id']]
        item.merge ({
            'name' => product.nombre,
            'unitPrice' => product.precio_venta,
            'total' => product.precio_venta * item['quantity']
        })
    end

    def add_subtotal_data(items)
        items.map { |i| i['total'] }.reduce(0) { |sum, num| sum + num }
    end

    def add_total_data(items)
        items.map { |i| i['total'] }.reduce(0) { |sum, num| sum + num }
    end
end
