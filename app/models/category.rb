class Category < Sequel::Model(:mantenedor_categoria)
    one_to_one :product
end
