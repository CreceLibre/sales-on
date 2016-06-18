#!/bin/env ruby
# encoding: utf-8

Fabricator(:order) do
    id { sequence }
    total 20
    subtotal_taxed 10
    subtotal_non_taxed 10
    payment_method 'webpay'
    email 'user@test.com'
    total_items 2
    pickup_location 'galpon'
end
