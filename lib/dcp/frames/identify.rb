class Dcp

  # Identify all request.
  IdentifyAllRequest = {
    frameId:        FRAME_ID[:identify_request],
    serviceId:      SERVICE_ID[:identify],
    serviceType:    SERVICE_TYPE[:request],
    xId:            XID,
    responseDelay:  RESPONSE_DELAY,
    dcpDataLength:  [ALL_SELECTOR_BLOCK.size].pack('n'),
    content:        ALL_SELECTOR_BLOCK
  }

  # Identify response.
  IdentifyResponse = Struct.new(:name, :mac_address, :ip_address, :subnet_mask, :description) do

    # Parse identify response frame.
    #
    # @param [String] frame raw frame as byte string
    # @return [IdentifyResponse] created structure or nil
    def self.parse(frame)
      return unless frame[FRAME_ID_RANGE] == FRAME_ID[:identify_response]
      device             = self.new
      device.mac_address = frame[SOURCE_MAC_ADDRESS_RANGE].to_mac

      i = FIRST_BLOCK_START
      while i < frame.size do
        block_size = frame[i+2..i+3].unpack('n').first
        case frame[i..i+1]
          when "#{BLOCK_OPTION[:device]}#{DEVICE_SUBOPTION[:vendor]}"   # device/vendor
            device.description = frame[i+6..i+6+block_size-2-1]
          when "#{BLOCK_OPTION[:device]}#{DEVICE_SUBOPTION[:name]}"     # device/name_of_station
            device.name = frame[i+6..i+6+block_size-2-1]
          when "#{BLOCK_OPTION[:ip]}#{IP_SUBOPTION[:ip]}"               # ip/ip
            device.ip_address  = frame[i+6..i+9].to_ip
            device.subnet_mask = frame[i+10..i+13].unpack('b*').first.count('1')
        end
        i += 4 + block_size
        i += 1 if block_size.odd?                                       # padding
      end

      device
    end

  end

end