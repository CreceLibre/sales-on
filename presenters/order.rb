class Order
    def entity
        Entity.new(self)
    end

    class Entity < Grape::Entity
        expose :id
        expose :email
    end
end
