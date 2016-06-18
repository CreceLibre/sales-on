#!/bin/env ruby
# encoding: utf-8

Fabricator(:line_item) do
    id { sequence }
    order
    product
    quantity 1
    value 10
    total 10
end
