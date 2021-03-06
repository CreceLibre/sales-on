#!/bin/env ruby
# encoding: utf-8

require 'spec_helper'

describe ProductAPI::V1 do
    def app
        ProductAPI::V1
    end

    let(:product1) do
        product = Fabricate.build :product
        product.isInCart = false
        product
    end

    let(:product2) do
        product = Fabricate.build :product, nombre: 'budweiser', category: product1.category
        product.isInCart = false
        product
    end

    describe 'GET /api/v1/products' do
        it 'returns an empty list of products' do
            allow(Product).to receive(:search).and_return []
            get '/api/v1/products', q: 'empty'

            expect(last_response.status).to eq Rack::Utils.status_code(:ok)
            expect(last_response.body).to eq({ 'products' => [] }.to_json)
        end

        it 'returns a list of products filtered by product name' do
            allow(Product).to receive(:search).and_return [product1]
            get '/api/v1/products', q: product1.nombre

            expect(last_response.status).to eq Rack::Utils.status_code(:ok)
            expect(last_response.body).to eq({
                'products' => [{
                    'id' => product1.id,
                    'name' => product1.nombre,
                    'category' => product1.category.nombre,
                    'isInCart' => false,
                    'price' => {
                      'amount': 1000,
                      'formattedAmount': '$1.000',
                      }
                }]
            }.to_json)
        end

        it 'returns a list of products' do
            allow(Product).to receive(:all).and_return [product1, product2]
            get '/api/v1/products'

            expect(last_response.status).to eq Rack::Utils.status_code(:ok)
            expect(last_response.body).to eq({
                'products' => [
                    {
                        'id' => product1.id,
                        'name' => product1.nombre,
                        'category' => product1.category.nombre,
                        'isInCart' => false,
                        'price' => {
                          'amount': 1000,
                          'formattedAmount': '$1.000',
                          }
                    },
                    {
                        'id' => product2.id,
                        'name' => product2.nombre,
                        'category' => product2.category.nombre,
                        'isInCart' => false,
                        'price' => {
                          'amount': 1000,
                          'formattedAmount': '$1.000',
                          }
                    }
                ]
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
            allow(Product).to receive(:[]).and_return product1
            get '/api/v1/products/2'

            expect(last_response.status).to eq Rack::Utils.status_code(:ok)
            expect(last_response.body).to eq({
                'product' => {
                    'id' => product1.id,
                    'name' => product1.nombre,
                    'category' => product1.category.nombre,
                    'isInCart' => false,
                    'price' => {
                      'amount': 1000,
                      'formattedAmount': '$1.000',
                      }
                }
            }.to_json)
        end
    end
end
