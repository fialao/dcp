class Dcp

  # Set ip address request.
  SetIpRequest = {
    frameId:          FRAME_ID[:set],
    serviceId:        SERVICE_ID[:set],
    serviceType:      SERVICE_TYPE[:request],
    xId:              XID,
    reserved:         "\x00\x00",
    dcpDataLength:    "\x00\x12",

    # IP/IP block
    block_option:     BLOCK_OPTION[:ip],
    block_suboption:  IP_SUBOPTION[:ip],
    dcpBlockLength:   "\x00\x0e",
    blockQuailfier:   CHANGE_DURATION[:permanent],
    ip_address:       "\xc0\xa8\x00\x01",     # 192.168.0.1
    subnet_mask:      "\xff\xff\xff\x00",     # 255.255.255.0
    gateway:          "\x00\x00\x00\x00"      # 0.0.0.0 (not set)
  }

  # Set response.
  SetResponse = Struct.new(:mac_address, :success) do

    # Parse set response frame.
    #
    # @param [String] frame raw frame as byte string
    # @return [IdentifyResponse] created structure or nil
    def self.parse(frame)
      return unless frame[FRAME_ID_RANGE] == FRAME_ID[:set]
      self.new(frame[SOURCE_MAC_ADDRESS_RANGE].to_mac, frame[FIRST_BLOCK_START + SET_RESPONSE_ERROR] == "\x00")
    end
  end

end