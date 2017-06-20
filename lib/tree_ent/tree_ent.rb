module TreeEnt
  FileUtils.mkdir_p(File.dirname(__FILE__) + '/../log/')
  LOG_FILE = File.new(File.dirname(__FILE__) + '/../log/' + name + '.log', 'w')
  LOG = Logger.new(LOG_FILE)
  FORMAT = Logger::Formatter.new
  MAX_LOG_LINES = 100
  LOG.formatter = proc { |severity, datetime, progname, msg|
    log_line = TreeEnt::FORMAT.call(severity, datetime, progname, msg.dump)
    TreeEnt.log_lines.unshift log_line
    TreeEnt.log_lines.slice!(TreeEnt.log_lines.count-1) if TreeEnt.log_lines.count > MAX_LOG_LINES
    log_line
  }

  # Singleton Pattern
  extend self

  module TreeEntMeta
    extend self

    def switch(name, gpio_pin)
      TreeEnt.add_switch name, gpio_pin
    end
  end

  private_constant :TreeEntMeta
  attr_reader :log_lines

  attr_reader :switches
  attr_reader :modules

  def start(&block)
    #RPi::GPIO.set_warnings false
    #RPi::GPIO.set_numbering :bcm
    #RPi::GPIO.clean_up
    @log_lines = []

    @switches = {}
    @modules = {}

    if block_given?
      TreeEntMeta.instance_exec(&block)
    end

    LOG.info "Rucket created!"
  end

  def add_module(name, mod)
    @modules[name] = mod
    LOG.info "Module #{name} added! #{mod}"
  end

  def add_switch(name, pin)
    switches[name] = Switch.new(pin)
    LOG.info "Switch #{name} added! pin#: #{pin}"
  end

  def update
    @modules.values.each do |mod|
      mod.main_loop unless mod.disabled?
    end
  end

  def [] i
    @modules[i]
  end
end