class Dcp

  # Profinet multicast MAC address for identify.
  IDENTIFY_MULTICAST_MAC = '01:0e:cf:00:00:00'


  # Identify all connected devices.
  #
  # @return [Hash<mac_address, identify_response>] hash of identify responses
  def identify_all
    responses_to IDENTIFY_MULTICAST_MAC, Frames::IdentifyRequest.new.all
  end

  # Identify one device.
  #
  # @param device_mac [String] device MAC address
  # @return [Hash<mac_address, identify_response>] hash of identify responses
  def identify(device_mac)
    responses_to device_mac, Frames::IdentifyRequest.new.all
  end

end
