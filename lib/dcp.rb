# Include core extensions, partial class definitions and frames
Dir.glob(File.join(File.dirname(__FILE__), 'dcp/**', '*.rb')) { |f| require f }

# DCP :: Discovery and basic Configuration Protocol
#
# Author: Ondra Fiala, mailto:ondra.fiala@gmail.com
class Dcp

  # Default network interface.
  DEFAULT_INTERFACE = 'eth0'

  # Default communication timeout [s].
  COMMUNICATION_TIMEOUT = 2


  # Network interface [String].
  attr_accessor :interface

  # Communication timeout [Fixnum].
  attr_accessor :timeout


  # DCP services initialization.
  #
  # @param interface [String] network interface
  # @param timeout [Fixnum] communication timeout
  def initialize(interface = DEFAULT_INTERFACE, timeout = COMMUNICATION_TIMEOUT)
    @interface = interface
    @timeout   = timeout
  end

end
