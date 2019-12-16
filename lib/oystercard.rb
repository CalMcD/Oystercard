class Oystercard
  attr_reader :balance, :in_use

  MINIMUM_CHARGE = 1

  def initialize
    @balance = 0
    @in_use = false
  end

  def top_up(amount)
    @amount = amount
    fail 'You cannot have a balance exceeding £90' if @balance + amount > 90
    @balance += amount
  end

  def touch_in
    fail 'Not enough funds available' if @balance < 1
    @in_use = true
  end

  def touch_out
    deduct(MINIMUM_CHARGE)
    @in_use = false
  end

  def in_journey?
    if @in_use == true
      true
    else
      false
    end
  end

  private

  def deduct(amount)
    @balance -= amount
  end

end
