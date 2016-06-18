#!/bin/env ruby
# encoding: utf-8

Fabricator(:product) do
    id { sequence }
    category
    codigo '7802100010070'
    codigo_manual false
    nombre 'heineken'
    precio_venta 1000
    exento_iva false
    descontinuado false
    precio_venta_distribuidor 847
    stock_real 1000
    stock_critico 200
    stock_ideal 3000
    precio_compra 400
end
