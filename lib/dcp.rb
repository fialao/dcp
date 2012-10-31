# Include core extensions, partial class definitions and frames
Dir.glob(File.join(File.dirname(__FILE__), 'dcp/**', '*.rb')) { |f| require f }

# Other gems
require 'packetfu'


# DCP :: Discovery and basic Configuration Protocol
#
# Author: Ondra Fiala, mailto:ondra.fiala@gmail.com
# Version: 0.1.0
class Dcp

  # Network interface.
  attr_accessor :interface

  # DCP services initialization.
  #
  # @param [String] interface network interface
  def initialize(interface = DEFAULT_INTERFACE)
    @interface = interface
  end


  private

  # Capture DCP packets.
  #
  # @param [Fixnum] timeout capture timeout
  # @yield
  def capture(timeout)
    cap = PacketFu::Capture.new(iface: @interface, filter: DCP_FILTER, timeout: timeout, start: true)
    yield
    sleep timeout
    cap.save

    cap.array
  end

  # Send DCP packet.
  #
  # @param [String] destination_mac destination mac address
  # @param [String] payload ethernet packet payload
  def send(destination_mac, payload)
    packet           = PacketFu::EthPacket.new
    packet.iface     = @interface
    packet.eth_saddr = PacketFu::Utils.ifconfig(@interface)[:eth_saddr]
    packet.eth_daddr = destination_mac
    packet.eth_proto = DCP_ETHERTYPE
    packet.payload   = payload
    packet.to_w
  end

end