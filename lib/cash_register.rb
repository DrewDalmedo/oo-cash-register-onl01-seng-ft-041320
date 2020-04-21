require 'pry'
class CashRegister
    # instance vars
    attr_accessor :total, :discount, :items_in_cart

    def initialize(discount=0)
        @total = 0
        @discount = discount
        @items_in_cart = {}
    end

    def add_item(title, price, quantity=1)
        @total += price * quantity

        if @items_in_cart.include?(title)
            @items_in_cart[title][:quantity] += 1
        else
            @items_in_cart[title] = {
                price: price,
                quantity: quantity
            }
        end
    end

    def apply_discount
        if !(@discount == 0)
            @total = (@total - (@total * (@discount.to_f / 100))).to_i
            return "After the discount, the total comes to $#{@total}."
        else
            return "There is no discount to apply."
        end
    end

    def items
        item_names = []
        @items_in_cart.each do |item_name, item_data|
            times = item_data[:quantity]
            while times != 0
                item_names << item_name
                times -= 1
            end
        end

        item_names
    end

    def void_last_transaction
        last_item = items.last

        @total -= @items_in_cart[last_item][:price] * @items_in_cart[last_item][:quantity]

        @total
    end
end
