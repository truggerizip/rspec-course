require 'deck'

module HighCard
  class CLI
    def self.default_account
      Banker.new(ENV.fetch('HIGHCARD_DIR', "/tmp/bank-accounts"), `whoami`.chomp)
    end

    def self.run(seed=rand(100000), deck: Deck.new, ui: UI.new, account: default_account)
      Kernel.srand seed.to_i

      if !account.exists?
        puts "Could not find bank account, you cannot play"
        return
      end

      hand     = deck.deal(5).sort_by(&:rank).reverse
      opposing = deck.deal(5).sort_by(&:rank).reverse

      ui.puts "Your hand is       #{hand.join(", ")}"
      start = Time.now
      input = ui.yesno_prompt("Bet $1 to win?")
      if Round.win?(input, hand, opposing)
        ui.puts "You won!"
        account.adjust!(1)
      else
        ui.puts "You lost!"
        account.adjust!(-1)
      end
      ui.puts "Opposing hand was  #{opposing.join(", ")}"
      ui.puts "Balance is #{account.balance}"
      ui.puts "You took #{Time.now - start}s to make a decision."
    end
  end

  class UI
    def yesno_prompt(message)
      print message + " Y/n"
      input = $stdin.gets
      input[0].downcase == "n"
    end

    def puts(message)
      $stdout.puts message
    end
  end

  class Round
    def self.win?(bet, hand, opposing)
      winning  = [hand, opposing]
        .sort_by {|h| h.map(&:rank).sort.reverse }
        .last

      bet ^ (opposing == winning)
    end
  end
end
