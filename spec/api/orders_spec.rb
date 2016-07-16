#!/bin/env ruby
# encoding: utf-8

require 'spec_helper'

describe OrderAPI::V1 do
    def app
        OrderAPI::V1
    end

    let(:order) do
        Fabricate.build :order
    end

    describe 'GET /api/v1/orders' do
        it 'fails when no order id is passed' do
            get '/api/v1/orders'

            expect(last_response.status).to eq Rack::Utils.status_code(:method_not_allowed)
            expect(last_response.body).to eq({ 'error' => '405 Not Allowed' }.to_json)
        end

        it 'returns the requested order by id' do
            allow(Order).to receive(:find).and_return order
            get "/api/v1/orders/#{order.uuid}"

            expect(last_response.status).to eq Rack::Utils.status_code(:ok)
            expect(last_response.body).to eql(
                { 'order' => {
                    'uuid' => order.uuid,
                    'id' => order.id,
                    'email' => order.email
                } }.to_json
            )
        end
    end

    describe 'POST /api/v1/orders' do
        it 'fails when no payload is passed' do
            post '/api/v1/orders'

            expect(last_response.status).to eq Rack::Utils.status_code(:bad_request)
            expect(last_response.body).to eq({ 'error' => 'email is missing, email is empty, payment_method is missing, payment_method does not have a valid value, pickup_location is missing, pickup_location is empty' }.to_json)
        end

        it 'fails when payment_method, pickup_location are missing' do
            post '/api/v1/orders', email: 'user@test.com'

            expect(last_response.status).to eq Rack::Utils.status_code(:bad_request)
            expect(last_response.body).to eq({ 'error' => 'payment_method is missing, payment_method does not have a valid value, pickup_location is missing, pickup_location is empty' }.to_json)
        end

        it 'fails when pickup_location is missing' do
            post '/api/v1/orders', email: 'user@test.com', payment_method: 'webpay'

            expect(last_response.status).to eq Rack::Utils.status_code(:bad_request)
            expect(last_response.body).to eq({ 'error' => 'pickup_location is missing, pickup_location is empty' }.to_json)
        end

        it 'fails when proper payload is passed but cart cookie is not present' do
            allow(Order).to receive(:create).and_return order
            post '/api/v1/orders', email: 'user@test.com', payment_method: 'webpay', pickup_location: 'galpon'

            expect(last_response.status).to eq Rack::Utils.status_code(:bad_request)
            expect(last_response.body).to eq({ 'error' => 'Cart is empty' }.to_json)
        end

        it 'succeeds when proper payload is passed and cookies is present' do
            allow(Order).to receive(:new).and_return order
            allow_any_instance_of(Cart).to receive(:empty?).and_return(false)
            post '/api/v1/orders', email: 'user@test.com', payment_method: 'webpay', pickup_location: 'galpon'

            expect(last_response.status).to eq Rack::Utils.status_code(:created)
            expect(last_response.body).to eql(
                { 'order' => {
                    'uuid' => order.uuid,
                    'id' => order.id,
                    'email' => order.email
                } }.to_json
            )
        end
    end
end
