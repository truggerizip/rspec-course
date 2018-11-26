require 'unit_helper'
require 'high_card/cli'

describe 'CLI' do
  example 'not betting on losing hand' do
    account = instance_double('HighCard::Banker', bogus: true)
      .as_null_object

    ui = instance_double(HighCard::UI).as_null_object
    expect(ui).to receive(:yesno_prompt).with(/Bet \$1/).and_return(false)
    expect(ui).to receive(:puts).with("You won!")

    round = class_double("HighCard::Round")
      .as_stubbed_const

    expect(round).to receive(:win?)
      .and_return(true)

    expect(account).to receive(:adjust!).with(1)

    HighCard::CLI.run(1, ui: ui, account: account)
  end
end
