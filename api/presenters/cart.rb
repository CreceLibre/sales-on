class Cart
    def entity
        Entity.new(self)
    end

    class Entity < Grape::Entity
        expose :items
    end
end
