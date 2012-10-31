class Dcp

  # Set device ip settings.
  #
  # @param [String] device_mac device MAC address
  # @param [String] ip_address new ip address
  # @param [String] subnet_mask new subnet mask as bit-length of the prefix
  # @param [String] gateway new gateway
  def set_ip(device_mac, ip_address, subnet_mask = DEFAULT_SUBNET_MASK, gateway = DEFAULT_GATEWAY, timeout = COMMUNICATION_TIMEOUT)
    frame               = SetIpRequest
    frame[:ip_address]  = ip_address.to_b
    frame[:subnet_mask] = (((1 << subnet_mask) - 1) << (32 - subnet_mask)).to_ip.to_b
    frame[:gateway]     = gateway.to_b
    frames = capture(timeout) { send device_mac, frame.to_b }

    frames.each do |frame|
      res = SetResponse.parse(frame)
      return true if res.mac_address == device_mac && res.success
    end
    false
  end

end