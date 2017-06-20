class TreeEnt::Switch
  attr_reader :pin

  def initialize(pin)
    @on = false
    @pin = pin
  end

  def turn_on
    @on = true
    TreeEnt::LOG.info "Switch[#{pin}]: Turned on!"
  end

  def turn_off
    @on = false
    TreeEnt::LOG.info "Switch[#{pin}]: Turned off!"
  end

  def off?
    not @on
  end

  def on?
    @on
  end

  def toggle
    if on?
      turn_off
    else
      turn_on
    end
  end
end