class Breakdown
    def entity
        Entity.new(self)
    end

    class Entity < Grape::Entity
        expose :breakdowns do
            expose :items
            expose :subtotal
            expose :total
        end

        private

        def items
            object.items.map { |i| present_item(i) }
        end

        def subtotal
            {
                currencyCode: 'CLP',
                amount: object.subtotal,
                formattedAmount: format_currency(object.subtotal)
            }
        end

        def total
            {
                currencyCode: 'CLP',
                amount: object.total,
                formattedAmount: format_currency(object.total)
            }
        end

        def present_item(i)
            {
                productId: i['product_id'],
                quantity: i['quantity'],
                name: i['name'],
                total: {
                    currencyCode: 'CLP',
                    amount: i['total'],
                    formattedAmount: format_currency(i['total'])
                },
                unitPrice: {
                    currencyCode: 'CLP',
                    amount: i['unitPrice'],
                    formattedAmount: format_currency(i['unitPrice'])
                }
            }
        end

        def format_currency(amount)
            Money.new(amount, 'CLP').format thousands_separator: '.', with_currency: true
        end
    end
end
