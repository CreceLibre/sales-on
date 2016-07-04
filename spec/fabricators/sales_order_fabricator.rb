#!/bin/env ruby
# encoding: utf-8

Fabricator(:order) do
    id { sequence }
    uuid "2d931510-d99f-494a-8c67-87feb05e1594"
    total 20
    subtotal_taxed 10
    subtotal_non_taxed 10
    payment_method 'webpay'
    email 'user@test.com'
    total_items 2
    pickup_location 'galpon'
end
