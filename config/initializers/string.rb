class String
  def to_bool
    return true if self =~ /^(true|t|yes|y|1)$/i
    return false if blank? || self =~ /^(false|f|no|n|0)$/i
    raise ArgumentError.new("invalid value for Boolean: \"#{self}\"")
  end
end
