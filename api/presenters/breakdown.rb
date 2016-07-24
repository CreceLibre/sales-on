class Breakdown
    def entity
        Entity.new(self)
    end

    class Entity < Grape::Entity
        expose :breakdowns do
            expose :items, using: 'BreakdownItem::Entity'
            expose :subtotal do
                expose :subtotal, as: :amount
                expose :subtotal, as: :formattedAmount, format_with: :currency
            end
            expose :total do
                expose :total, as: :amount
                expose :total, as: :formattedAmount, format_with: :currency
            end
        end
    end
end
