class Product < Sequel::Model(:mantenedor_mercaderia)
    attr_accessor :isInCart
    many_to_one :category, key: :categoria_id

    dataset_module do
        def search(q, cart)
            result = where(Sequel.like(:nombre, "%#{q}%")).all
            result.map { |r| cart.add_flag_to_product r }
        end

        def fetch_all(cart)
            all.map { |r| cart.add_flag_to_product r }
        end
    end
end
