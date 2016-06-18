#!/bin/env ruby
# encoding: utf-8

require 'spec_helper'

describe ProductAPI::V1 do
    def app
        ProductAPI::V1
    end

    let(:product) do
        Fabricate.build :product
    end

    describe 'GET /api/v1/products' do
        it 'returns an empty list of products' do
            allow(Product).to receive(:search).and_return []
            get '/api/v1/products', q: 'empty'

            expect(last_response.status).to eq Rack::Utils.status_code(:ok)
            expect(last_response.body).to eq({ 'products' => [] }.to_json)
        end

        it 'returns a list of products' do
            allow(Product).to receive(:search).and_return [product]
            get '/api/v1/products', q: 'beer'

            expect(last_response.status).to eq Rack::Utils.status_code(:ok)
            expect(last_response.body).to eq({
                'products' => [{
                    'id' => product.id,
                    'name' => 'heineken',
                    'category' => 'beer'
                }]
            }.to_json)
        end
    end

    describe 'GET /api/v1/products/:id' do
        it 'returns an empty product for a non existent id' do
            allow(Product).to receive(:[]).and_return nil
            get '/api/v1/products/11'

            expect(last_response.status).to eq Rack::Utils.status_code(:ok)
            expect(last_response.body).to eq({ 'product' => nil }.to_json)
        end

        it 'returns a specific product' do
            allow(Product).to receive(:[]).and_return [product]
            get '/api/v1/products/2'

            expect(last_response.status).to eq Rack::Utils.status_code(:ok)
            expect(last_response.body).to eq({
                'product' => [{
                    'id' => product.id,
                    'name' => 'heineken',
                    'category' => 'beer'
                }]
            }.to_json)
        end
    end
end
