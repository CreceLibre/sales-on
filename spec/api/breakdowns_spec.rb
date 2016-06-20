#!/bin/env ruby
# encoding: utf-8

require 'spec_helper'

describe BreakdownAPI::V1 do
    def app
        BreakdownAPI::V1
    end

    let(:raw_items) do
        [
            {
                'product_id' => 1,
                'quantity' => 2,
                'name' => 'heineken',
                'unitPrice' => 1000,
                'total' => 2000

            }
        ]
    end

    let(:raw_subtotal) do
      2000
    end

    let(:raw_total) do
      2000
    end

    describe 'GET /api/v1/breakdowns' do
        it 'returns a breakdowns' do
            allow_any_instance_of(Breakdown).to receive(:items).and_return raw_items
            allow_any_instance_of(Breakdown).to receive(:subtotal).and_return raw_subtotal
            allow_any_instance_of(Breakdown).to receive(:total).and_return raw_total
            get '/api/v1/breakdowns'

            expect(last_response.status).to eq Rack::Utils.status_code(:ok)
            expect(last_response.body).to eq(
                { breakdowns:
                    { items:
                        [
                            { productId: 1,
                              quantity: 2,
                              name: 'heineken',
                              total: {
                                  currencyCode: 'CLP',
                                  amount: 2000,
                                  formattedAmount: '$2.000 CLP'
                              },
                              unitPrice: {
                                  currencyCode: 'CLP',
                                  amount: 1000,
                                  formattedAmount: '$1.000 CLP'
                              } }
                        ],
                      subtotal: {
                          currencyCode: 'CLP',
                          amount: 2000,
                          formattedAmount: '$2.000 CLP'
                      },
                      total: {
                          currencyCode: 'CLP',
                          amount: 2000,
                          formattedAmount: '$2.000 CLP'
                      } } }.to_json
            )
        end
    end
end
