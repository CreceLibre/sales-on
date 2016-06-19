require 'securerandom'
require 'json'

class Cart
    attr_accessor :items, :id

    def initialize(cookies)
        @cookies = cookies
        @cookies[:cart] ||= SecureRandom.uuid
        @id = @cookies[:cart]
        items = R.get(@id)
        @items = if items
                     JSON.parse(items)
                 else
                     []
                 end
    end

    def add_item(item)
        @items << item
    end

    def remove_item(id)
        @items = @items.select do |hash|
            hash[:product_id] != id
        end
    end

    def update_item(item)
        @items = @items.map do |hash|
            if hash[:product_id] == item[:product_id]
                hash[:quantity] = item[:quantity]
                hash
            else
                hash
            end
        end
    end

    def empty?
        @items.empty?
    end

    def delete
        R.del @id
        @cookies.delete :cart
        @items = []
    end

    def save
        # TODO: Add timeout for anonymous carts (?)
        R.set @id, @items.to_json
    end
end
