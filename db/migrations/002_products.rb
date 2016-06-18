Sequel.migration do
    up do
        create_table(:mantenedor_mercaderia) do
            primary_key :id
            foreign_key :categoria_id, :mantenedor_categoria
            String      :codigo,                    size: 255, null: false
            Boolean     :codigo_manual,             null: false
            String      :nombre,                    size: 255, null: false
            Integer     :precio_venta,              null: false
            Boolean     :exento_iva,                null: false
            Boolean     :descontinuado,             null: false
            Integer     :precio_venta_distribuidor, null: false
            Integer     :stock_real,                null: false
            Integer     :stock_critico,             null: false
            Integer     :stock_ideal,               null: false
            Integer     :precio_compra,             null: false, default: 0
        end
    end

    down do
        drop_table(:mantenedor_mercaderia)
    end
end
