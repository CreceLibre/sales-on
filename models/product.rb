class Product < Sequel::Model(:mantenedor_mercaderia)
    attr_accessor :isInCart
    many_to_one :category, key: :categoria_id

    dataset_module do
        def search(q)
          where(Sequel.like(:nombre, "%#{q}%")).all
        end
    end
end
