class Order
    def entity
        Entity.new(self)
    end

    class Entity < Grape::Entity
        expose :uuid
        expose :id
        expose :email
    end
end
