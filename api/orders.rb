#!/bin/env ruby
# encoding: utf-8

module OrderAPI
    class V1 < Grape::API
        version 'v1', using: :path, vendor: 'CreceLibre'
        content_type :json, 'application/json;charset=UTF-8'

        resource :orders do
            desc 'Places an order.'
            params do
                requires :email, type: String, allow_blank: false, desc: 'User\'s email.'
                requires :payment_method, type: String, values: ['webpay']
                requires :pickup_location, type: String, allow_blank: false
            end
            post '/' do
                # TODO: pull data from cart
                @order = Order.create params
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
