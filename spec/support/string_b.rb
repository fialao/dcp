class String

  # Fix MRI 2.0 UTF-8 support for MRI 1.9
  def b
    self
  end

end
