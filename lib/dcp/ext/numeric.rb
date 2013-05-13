class Numeric

  # Convert to IP address format (C.C.C.C).
  #
  # @return [String] formatted as IP address
  def to_ip
    self.to_s(16).unpack('A2A2A2A2').map(&:hex).join('.')
  end

  # Convert to Unsigned8 string.
  #
  # @return [String] formatted as Unsigned8
  def to_byte
    self.chr
  end

  # Convert to Unsigned16 string.
  #
  # @return [String] formatted as Unsigned16
  def to_word
    [self].pack('n')
  end

  # Convert to Unsigned32 string.
  #
  # @return [String] formatted as Unsigned32
  def to_double
    [self].pack('N')
  end

end
