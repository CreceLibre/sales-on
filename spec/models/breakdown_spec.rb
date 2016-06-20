require 'spec_helper'

describe Breakdown do
    let(:product) do
        Fabricate :product
    end

    let(:breakdowns) do
        allow(Product).to receive(:[]).and_return(product)
        Breakdown.new [
            {
                'product_id' => 1,
                'quantity' => 2

            }
        ]
    end

    context '#total' do
        it 'returns the breakdowns total' do
            expect(breakdowns.total).to eq 2000
        end
    end

    context '#subtotal' do
        it 'returns the breakdowns total' do
            expect(breakdowns.subtotal).to eq 2000
        end
    end

    context '#items' do
        it 'returns the breakdowns total' do
            expect(breakdowns.items).to eq(
                [
                    {
                        'product_id' => 1,
                        'quantity' => 2,
                        'name' => 'heineken',
                        'unitPrice' => 1000,
                        'total' => 2000

                    }
                ]
            )
        end
    end
end
