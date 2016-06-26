#!/bin/env ruby
# encoding: utf-8

require 'spec_helper'

describe CartAPI::V1 do
    def app
        CartAPI::V1
    end

    let(:cookies) do
        cookies = {}
    end

    let(:empty_cart) do
        R.flushall
        Cart.new 1
    end

    let(:cart) do
        cart = Cart.new cookies
        cart.add_item(product_id: 1,
                      quantity: 2)

        cart
    end

    describe 'GET /api/v1/cart' do
        it 'returns and empty list for the current cart' do
            allow(Cart).to receive(:new).and_return empty_cart
            get '/api/v1/cart'

            expect(last_response.status).to eq Rack::Utils.status_code(:ok)
            expect(last_response.body).to eq(
                { 'items' => [] }.to_json
            )
        end
        it 'returns a list for the current cart' do
            allow(Cart).to receive(:new).and_return cart
            get '/api/v1/cart'

            expect(last_response.status).to eq Rack::Utils.status_code(:ok)
            expect(last_response.body).to eq(
                { 'items' => [{
                    product_id: 1,
                    quantity: 2
                }] }.to_json
            )
        end
    end

    describe 'POST /api/v1/cart' do
        it 'adds an item into the cart' do
            allow(Cart).to receive(:new).and_return empty_cart
            post '/api/v1/cart', product_id: 1

            expect(last_response.status).to eq Rack::Utils.status_code(:created)
            expect(last_response.body).to eq "OK".to_json
        end
    end

    describe 'DELETE /api/v1/cart/:product_id' do
        it 'deletes an item from cart' do
            allow(Cart).to receive(:new).and_return cart
            delete '/api/v1/cart/1'

            expect(last_response.status).to eq Rack::Utils.status_code(:ok)
            expect(last_response.body).to eq "OK".to_json
        end
    end

    describe 'PUT /api/v1/cart/' do
        it 'deletes an item from cart' do
            allow(Cart).to receive(:new).and_return cart
            put '/api/v1/cart/1', product_id: 1, quantity: 9

            expect(last_response.status).to eq Rack::Utils.status_code(:ok)
            expect(last_response.body).to eq "OK".to_json
        end
    end
end
