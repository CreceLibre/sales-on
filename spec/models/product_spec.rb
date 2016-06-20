require 'spec_helper'

describe Product do
    before do
        Fabricate :product
    end

    context '#search' do
        it 'returns an empty list' do
            result = Product.search 'non-existant'
            expect(result.count).to eq 0
        end

        it 'returns a single product' do
            result = Product.search 'heineken'
            expect(result.count).to eq 1
        end
    end
end
