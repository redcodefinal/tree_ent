class TreeEnt::TModule

  attr_reader :name

  def initialize(name)
    @name = name
    @disabled = false
  end

  def disable
    @disabled = true
    TreeEnt::LOG.info "TModule[#{name}]: disabled!"
  end

  def enable
    @disabled = false
    TreeEnt::LOG.info "TModule[#{name}]: enabled!"
  end

  def disabled?
    @disabled
  end

  def toggle
    if disabled?
      enable
    else
      disable
    end
  end
end