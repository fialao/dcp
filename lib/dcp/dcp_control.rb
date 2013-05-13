class Dcp

  # Physically detect device. Flash a LED (e.g. the Ethernet LINK LED) or an alternative signalization with duration of 3s.
  #
  # @param device_mac [String] device MAC address
  # @return [String] operation result
  def signal(device_mac)
    result_of device_mac, Frames::SetRequest.new.signal
  end

  # Reset device to factory settings. The NameOfStation to "", the IP address, the subnet mask and the standard gateway to 0.0.0.0
  # and all other parameters to the manufacturers default value.
  #
  # @param device_mac [String] device MAC address
  # @return [String] operation result
  def factory_reset(device_mac)
    result_of device_mac, Frames::SetRequest.new.factory_reset
  end

end
