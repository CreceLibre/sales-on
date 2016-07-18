require 'spec_helper'

describe Breakdown do
    let(:product) do
        Fabricate :product
    end

    let(:breakdownItem) do
        Fabricate.build :breakdown_item
    end


    let(:breakdowns) do
        allow(BreakdownItem).to receive(:new).and_return(breakdownItem)
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
                  breakdownItem
                ]
            )
        end
    end
end
