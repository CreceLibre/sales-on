Sequel.migration do
    up do
        create_table(:sales_line_item) do
            primary_key :id
            foreign_key :order_id, :sales_order
            foreign_key :product_id, :mantenedor_mercaderia
            Integer     :quantity,                  null: false
            Integer     :value,                     null: false
            Integer     :total,                     null: false
        end
    end

    down do
        drop_table(:sales_line_item)
    end
end
