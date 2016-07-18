
class Breakdown
    attr_reader :items, :subtotal, :total

    def initialize(items)
        @items = items.map { |i| BreakdownItem.new i }
        build
    end

    private

    def build
        # TODO: discount should be added here
        @subtotal = add_subtotal_data @items
        @total = add_total_data @items
    end


    def add_subtotal_data(items)
        items.map { |i| i.total }.reduce(0) { |sum, num| sum + num }
    end

    def add_total_data(items)
        items.map { |i| i.total }.reduce(0) { |sum, num| sum + num }
    end
end
