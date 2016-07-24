class BreakdownItem
    def entity
        Entity.new(self)
    end

    class Entity < Grape::Entity
        expose :productId
        expose :quantity
        expose :name
        expose :total do
            expose :total, as: :amount
            expose :total, as: :formattedAmount, format_with: :currency
        end
        expose :unitPrice do
            expose :unitPrice, as: :amount
            expose :unitPrice, as: :formattedAmount, format_with: :currency
        end
    end
end
