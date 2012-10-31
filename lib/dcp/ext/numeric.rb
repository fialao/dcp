class Numeric

  # 1's complement.
  #
  # @return [Numeric] 1's complement
  def ones_complement(bits)
    self ^ ((1 << bits) - 1)
  end

  # Convert to IP address format (C.C.C.C).
  #
  # @return [String] formatted as IP address
  def to_ip
    self.to_s(16).unpack('A2A2A2A2').map(&:hex).join('.')
  end

end