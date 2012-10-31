class Numeric

  # 1's complement.
  #
  # @return [Numeric] 1's complement
  def ones_complement(bits)
    self ^ ((1 << bits) - 1)
  end

end