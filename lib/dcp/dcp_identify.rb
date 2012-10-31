class Dcp

  # Identify all connected devices.
  #
  # @param [Fixnum] timeout identify timeout
  # @return [Hash] devices as device info hashes
  def identify_all(timeout = IDENTIFY_TIMEOUT)
    frames = capture(timeout) { send IdentifyAllRequest.to_b }

    devices = []
    frames.each do |frame|
      device = IdentifyResponse.parse(frame)
      devices.push device unless device.nil?
    end

    devices
  end

end