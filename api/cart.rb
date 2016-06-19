#!/bin/env ruby
# encoding: utf-8

require 'date'

module CartAPI
    class V1 < Grape::API
        version 'v1', using: :path, vendor: 'CreceLibre'
        content_type :json, 'application/json;charset=UTF-8'

        resource :cart do
            desc 'Adds and item into the cart.'
            params do
                requires :product_id, type: Integer, desc: 'Product\'s id.'
                requires :quantity, type: Integer, desc: 'Product\'s quantity.'
            end
            post '/' do
                cart = Cart.new cookies
                cart.add_item params
                cart.save
            end

            desc 'Get cart contents.'
            get '/' do
                cart = Cart.new cookies
                present cart
            end

            desc 'Delete a cart item.'
            params do
                requires :product_id, type: Integer, desc: 'Product\'s id.'
            end
            delete ':product_id' do
                cart = Cart.new cookies
                cart.remove_item params[:product_id]
                cart.save
            end

            desc 'Updates a cart item.'
            params do
                requires :product_id, type: Integer, desc: 'Product\'s id.'
                requires :quantity, type: Integer, desc: 'Product\'s quantity.'
            end
            put ':product_id' do
                cart = Cart.new cookies
                cart.update_item params
                cart.save
            end
        end
    end
end