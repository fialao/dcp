require 'packetfu'

class Dcp

  # Profinet (DCP) protocol ethertype.
  DCP_ETHERTYPE = 0x8892

  # BPF (Berkeley Packet Filter) for DCP.
  DCP_FILTER = "ether proto #{DCP_ETHERTYPE}"

  # Destination MAC address range.
  DESTINATION_MAC_ADDRESS_RANGE = 0..5

  # Source MAC address range.
  SOURCE_MAC_ADDRESS_RANGE = 6..11


  private

    # MAC address for interface.
    #
    # @return [String] MAC address
    def interface_mac_address
      PacketFu::Utils.ifconfig(@interface)[:eth_saddr]
    end

    # Send DCP packet.
    #
    # @param destination_mac [String] destination mac address
    # @param payload [String] ethernet packet payload
    def send(destination_mac, payload)
      packet           = PacketFu::EthPacket.new
      packet.iface     = @interface
      packet.eth_saddr = interface_mac_address
      packet.eth_daddr = destination_mac
      packet.eth_proto = DCP_ETHERTYPE
      packet.payload   = payload
      packet.to_w
    end

    # Capture DCP packets.
    #
    # @yield [] operations before capturing
    # @return [Array] list of captured packets
    def capture
      cap = PacketFu::Capture.new(iface: @interface, filter: DCP_FILTER, timeout: @timeout, start: true)
      yield
      sleep @timeout
      cap.save
      cap.array
    end

    # Request-response pattern.
    #
    # @param destination_mac [String] request destination mac address
    # @param request [String] request frame
    # @return [Array] list of response frames
    def responses_to(destination_mac, request)
      request.xid = rand(0xFFFFFFFF)
      frames      = capture { send destination_mac, request.to_b }

      responses = {}
      frames.each do |frame|
        response    = Frames::Common.create_from(frame)
        source_mac  = frame[SOURCE_MAC_ADDRESS_RANGE].to_mac
        responses[source_mac] = response if response && response.xid == request.xid && response.type != :request
      end
      responses
    end

    # Perform request operation and return result.
    #
    # @param device_mac [String] device MAC address
    # @param request [Frames::Object] instance of frame
    # @return [String] operation result
    def result_of(device_mac, request)
      responses = responses_to(device_mac, request)
      unless responses.empty?
        responses.values.first.blocks.first.response_error.to_s
      else
        nil
      end
    end

end
