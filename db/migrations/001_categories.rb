Sequel.migration do
    up do
        create_table(:mantenedor_categoria) do
            primary_key :id
            String      :nombre, size: 255, null: false, unique: true
            Decimal     :ila, null: false
        end
    end

    down do
        drop_table(:mantenedor_categoria)
    end
end
