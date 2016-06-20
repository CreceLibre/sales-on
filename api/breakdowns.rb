#!/bin/env ruby
# encoding: utf-8

module BreakdownAPI
    class V1 < Grape::API
        version 'v1', using: :path, vendor: 'CreceLibre'
        content_type :json, 'application/json;charset=UTF-8'

        resource :breakdowns do
            desc 'Builds and return a breakdowns.'
            get '/' do
                cart = Cart.new cookies[:cart]
                @breakdowns = Breakdown.new cart.items
                present @breakdowns
            end
        end
    end
end
