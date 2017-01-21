class NABTransactionsPage < SitePrism::Page
  class TransactionSection < SitePrism::Section
    elements :table_cells, 'td'

    def data
      {
        effective_date: effective_date,
        description: description,
        amount: amount,
      }
    end

    private

    def effective_date
      DateTime.strptime(raw_data[0], '%d %b %y')
    end

    def description
      raw_data[1]
    end

    def debit_amount
      Money.new(raw_data[2].presence || 0)
    end

    def credit_amount
      Money.new(raw_data[3].presence || 0)
    end

    def amount
      [debit_amount, credit_amount].reject(&:zero?).first.to_i
    end

    def raw_data
      @raw_data ||= table_cells.map(&:text)
    end
  end
end
