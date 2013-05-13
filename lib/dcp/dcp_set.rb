class Dcp

  # Set name of station for device.
  #
  # @param device_mac [String] device MAC address
  # @param name_of_station [String] name of station
  # @param change_duration [Symbol] change duration as `permanent` or `temporary`
  # @return [String] operation result
  def set_name(device_mac, name_of_station, change_duration = :permanent)
    result_of device_mac, Frames::SetRequest.new.name(name_of_station, change_duration)
  end

  # Set ip parameters for device.
  #
  # @param device_mac [String] device MAC address
  # @param ip_address [String] IP address
  # @param subnet_mask [String] subnet mask
  # @param standard_gateway [String] standard mask
  # @param change_duration [Symbol] change duration as `permanent` or `temporary`
  # @return [String] operation result
  def set_ip(device_mac, ip_address, subnet_mask = '255.255.255.0', standard_gateway = '0.0.0.0', change_duration = :permanent)
    result_of device_mac, Frames::SetRequest.new.ip(ip_address, subnet_mask, standard_gateway, change_duration)
  end

end
