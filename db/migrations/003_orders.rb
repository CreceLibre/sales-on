Sequel.migration do
    up do
        # TODO:
        # - add `date` column
        # - `pickup_location` should be multi-valued (?)
        create_table(:sales_order) do
            primary_key :id
            String      :uuid,                      size: 36, null: false
            Integer     :total,                     null: false
            Integer     :subtotal_taxed,            null: false
            Integer     :subtotal_non_taxed,        null: false
            String      :payment_method,            size: 25, null: false
            String      :email,                     size: 255, null: false
            Integer     :total_items,               null: false
            String      :pickup_location,           size: 25, null: false
        end
    end

    down do
        drop_table(:sales_order)
    end
end
