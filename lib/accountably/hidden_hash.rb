class HiddenHash < Hash
  def self.new_from_hash(other_hash)
    new.tap do |hash|
      other_hash.each do |key, value|
        hash[key] = value
      end
    end
  end

  def inspect
    to_s
  end

  def to_s
    '(hidden)'
  end
end
