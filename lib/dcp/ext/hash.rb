class Hash

  # Convert hash values to byte string.
  #
  # @return [String] converted hash values
  def to_b
    values.join
  end

end