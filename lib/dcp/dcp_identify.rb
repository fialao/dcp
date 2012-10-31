class Dcp

  # Identify all connected devices.
  #
  # @param [Fixnum] timeout identify timeout
  # @return [Hash] devices as device info hashes
  def identify_all(timeout = COMMUNICATION_TIMEOUT)
    frames = capture(timeout) { send IDENTIFY_MULTICAST_MAC, IdentifyAllRequest.to_b }

    devices = []
    frames.each do |frame|
      device = IdentifyResponse.parse(frame)
      devices.push device unless device.nil?
    end
    devices
  end

  # Identify one device.
  #
  # @param [String] device_mac device MAC address
  # @param [Fixnum] timeout identify timeout
  # @return [Hash] device info
  def identify(device_mac, timeout = COMMUNICATION_TIMEOUT)
    frames = capture(timeout) { send device_mac, IdentifyAllRequest.to_b }

    device = nil
    frames.each do |frame|
      d = IdentifyResponse.parse(frame)
      device = d if d && d.mac_address == device_mac
    end
    device
  end
end