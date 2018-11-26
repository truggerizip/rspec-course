require 'bank'

sleep 1

module HighCard
  class Banker
    def initialize(path, login)
      @bank = Bank.new(path)
      @login = login
      @account = @bank.accounts.detect {|x| x.name == login }
    end

    def adjust!(amount)
      if amount > 0
        @account.credit!(@login, amount)
      else
        @account.debit!(@login, amount * -1)
      end
    end

    def exists?
      @account
    end

    def balance
      @account.balance
    end
  end
end
