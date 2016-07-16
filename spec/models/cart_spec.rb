require 'spec_helper'

describe Cart do
    before do
        R.flushall
        @cart = Cart.new 1
    end

    context '#items' do
        it 'returns an empty list' do
            expect(@cart.items).to eq []
        end
    end

    context '#add_item' do
        it 'adds an item to existent empty list' do
            @cart.add_item(product_id: 1)
            expect(@cart.items.length).to eq 1
            expect(@cart.items).to eq(
                [
                    {
                        product_id: 1
                    }
                ]
            )
        end
    end

    context '#empty?' do
        it 'should return true when cart is empty' do
            expect(@cart.empty?).to eq true
        end
        it 'should return false when cart is not empty' do
            @cart.add_item(product_id: 1)
            expect(@cart.empty?).to eq false
        end
    end

    context '#delete' do
        it 'should clear the items list' do
            @cart.add_item(product_id: 1)
            @cart.delete
            expect(@cart.items.length).to eq 0
        end
    end

    context '#save' do
        it 'should trigger redis call' do
            expect(R).to receive(:set)
            @cart.save
        end
    end

    context '#remove_item' do
        it 'removes an item from existent list' do
            @cart.add_item({'product_id' => 1})
            @cart.add_item({'product_id' => 2})
            @cart.remove_item(1)
            expect(@cart.items.length).to eq 1
            expect(@cart.items).to eq(
                [
                    {
                        'product_id' => 2
                    }
                ]
            )
        end
    end

    context '#update_item' do
        it 'updates an item from existent list' do
            @cart.add_item({'product_id' => 1, 'quantity' => 2})
            @cart.add_item({'product_id' => 2, 'quantity' => 4})
            @cart.add_item({'product_id' => 3, 'quantity' => 7})
            @cart.update_item({'product_id'=> 2, 'quantity'=> 9})
            expect(@cart.items.length).to eq 3
            expect(@cart.items).to eq(
                [
                    {
                        'product_id' => 1,
                        'quantity' => 2
                    },
                    {
                        'product_id' => 2,
                        'quantity' => 9
                    },
                    {
                        'product_id' => 3,
                        'quantity' => 7
                    }
                ]
            )
        end
    end
end
