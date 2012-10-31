class String

  # Convert to MAC address format (H2:H2:H2:H2:H2:H2).
  #
  # @return [String] formatted as MAC address
  def to_mac
    self.unpack('H2H2H2H2H2H2').join(':')
  end

  # Convert to IP address format (C.C.C.C).
  #
  # @return [String] formatted as IP address
  def to_ip
    self.unpack('CCCC').join('.')
  end

  # Convert IP address format (C.C.C.C) to byte string.
  #
  # @return [String] converted to byte string
  def to_b
    self.split('.').map(&:to_i).pack('C*')
  end

end