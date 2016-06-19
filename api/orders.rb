#!/bin/env ruby
# encoding: utf-8

module OrderAPI
    class V1 < Grape::API
        version 'v1', using: :path, vendor: 'CreceLibre'
        content_type :json, 'application/json;charset=UTF-8'
        helpers do
            def empty_cart!
                error!({ error: 'Cart is empty' }, 400, 'Content-Type' => 'text/error')
            end
        end
        resource :orders do
            desc 'Places an order.'
            params do
                requires :email, type: String, allow_blank: false, desc: 'User\'s email.'
                requires :payment_method, type: String, values: ['webpay']
                requires :pickup_location, type: String, allow_blank: false
            end
            post '/' do
                cart = Cart.new cookies
                empty_cart! if cart.empty?
                Order.db.transaction do
                    @order = Order.new params
                    cart.items.each do |item|
                        line_item = LineItem.new item
                        line_item.product = Product[item['product_id']]
                        @order.line_items << line_item
                    end
                    @order.save
                end
                cart.delete
                present :order, @order
            end

            desc 'Get a specified order.'
            params do
                requires :id, type: Integer, desc: 'Order\'s id.'
            end
            get ':id' do
                @order = Order[params[:id]]
                present :order, @order
            end
        end
    end
end
