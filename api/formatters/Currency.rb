module ApiHelpers
    extend Grape::API::Helpers

    Grape::Entity.format_with :currency do |amount|
        Money.new(amount, 'CLP').format thousands_separator: '.', with_currency: false
    end
end
