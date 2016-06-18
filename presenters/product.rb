class Product
    def entity
        Entity.new(self)
    end

    class Entity < Grape::Entity
        expose :id
        expose :nombre, as: :name
        expose :category

        private

        def category
            object.category.nombre
        end
    end
end
