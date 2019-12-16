require 'oystercard'

describe Oystercard do
  it 'should start with a balace of 0' do
    my_oystercard = Oystercard.new
    expect(my_oystercard.balance).to eq(0)
  end

  it 'should be able to top up with any given amount' do
    my_oystercard = Oystercard.new
    expect(my_oystercard).to respond_to(:top_up).with(1).argument
  end

  it 'should add amount to the current balance' do
    my_oystercard = Oystercard.new
    expect(my_oystercard.top_up(10)).to eq 10
  end

  it 'should have a maximum balance of £90' do
    my_oystercard = Oystercard.new
    expect{ my_oystercard.top_up(100) }.to raise_error 'You cannot have a balance exceeding £90'
  end

  it 'should touch in' do
    my_oystercard = Oystercard.new
    expect(my_oystercard).to respond_to(:touch_in)
  end

  it 'should touch out' do
    my_oystercard = Oystercard.new
    expect(my_oystercard).to respond_to(:touch_out)
  end

  it 'is initially not in a journey' do
    my_oystercard = Oystercard.new
    expect(my_oystercard).not_to be_in_journey
  end

  it 'starts not in a journey' do
    my_oystercard = Oystercard.new
    expect(my_oystercard.in_journey?).to eq false
  end

  it 'sets the card as in use after tap in' do
    my_oystercard = Oystercard.new
      my_oystercard.top_up(10)
    expect(my_oystercard.touch_in).to eq true
  end

  it 'sets the card as out of use after touch out' do
    my_oystercard = Oystercard.new
    my_oystercard.top_up(10)
    my_oystercard.touch_in
    expect(my_oystercard.touch_out).to eq false
  end

  it 'needs a minimum of £1 balance to touch in' do
    my_oystercard = Oystercard.new
    expect{ my_oystercard.touch_in }.to raise_error 'Not enough funds available'
  end

  it 'should deduct minimum fare after touching out' do
    my_oystercard = Oystercard.new
    my_oystercard.top_up(10)
    my_oystercard.touch_in
    expect { my_oystercard.touch_out }.to change { my_oystercard.balance }.by(-Oystercard::MINIMUM_CHARGE)
  end
end
