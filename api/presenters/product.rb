class Product
    def entity
        Entity.new(self)
    end

    class Entity < Grape::Entity
        expose :id
        expose :nombre, as: :name
        expose :category
        expose :isInCart
        expose :price do
            expose :precio_venta, as: :amount
            expose :precio_venta, as: :formattedAmount, format_with: :currency
        end

        private

        def category
            object.category.nombre
        end
    end
end
