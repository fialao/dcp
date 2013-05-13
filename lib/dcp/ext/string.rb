class String

  # Converts to UpperCamelCase.
  #
  # @return [String] camelized string
  def camelize
    self.split("_").collect(&:capitalize).join
  end

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

  # Convert to Unsigned8 fixnum.
  #
  # @return [Fixnum] formatted as Unsigned8
  def to_byte
    self.ord
  end

  # Convert to Unsigned16 fixnum.
  #
  # @return [Fixnum] formatted as Unsigned16
  def to_word
    self.unpack('n').first
  end

  # Convert to Unsigned32 fixnum.
  #
  # @return [Fixnum] formatted as Unsigned32
  def to_double
    self.unpack('N').first
  end

end
