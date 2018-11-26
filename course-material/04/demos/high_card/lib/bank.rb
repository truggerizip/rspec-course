class Bank
  class Account
    attr_reader :name, :balance

    def initialize(path, name)
      @path = path
      FileUtils.mkdir_p(path)
      @name = name
      @balance = File.read(path + "/#{name}").to_i rescue 0
    end

    def debit!(account, amount)
      raise if account != name
      @balance -= amount
      write!
    end

    def credit!(account, amount)
      raise if account != name
      @balance += amount
      write!
    end

    private

    def write!
      File.write(@path + "/#{name}", balance)
    end
  end

  def initialize(path)
    @path = path
  end

  def accounts
    [Account.new(@path, `whoami`.chomp), Account.new(@path, "tester")]
  end
end
