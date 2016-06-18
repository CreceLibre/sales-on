#!/bin/env ruby
# encoding: utf-8

module ProductAPI
    class V1 < Grape::API
        version 'v1', using: :path, vendor: 'CreceLibre'
        content_type :json, 'application/json;charset=UTF-8'

        resource :products do
            desc 'Searches for products.'
            params do
                requires :q, type: String, desc: 'Search query.'
            end
            get '/' do
                @products = Product.search params[:q]
                present :products, @products
            end

            desc 'Get a specified product.'
            params do
                requires :id, type: Integer, desc: "Product's id."
            end
            get ':id' do
                @product = Product[params[:id]]
                present :product, @product
            end
        end
    end
end
