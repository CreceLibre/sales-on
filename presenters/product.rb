class Product
    def entity
        Entity.new(self)
    end

    class Entity < Grape::Entity
        expose :id
        expose :nombre, as: :name
        expose :category
        expose :precio_venta, as: :price, format_with: :currency

        private

        def category
            object.category.nombre
        end

    end
end
