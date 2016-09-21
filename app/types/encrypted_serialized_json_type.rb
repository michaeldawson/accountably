class EncryptedSerializedJSONType < ActiveRecord::Type::Value
  def serialize(value)
    encrypt(JSON.dump(value))
  end

  def deserialize(value)
    JSON.parse(decrypt(value)).deep_symbolize_keys
  end

  def cast(value)
    value.deep_symbolize_keys
  end

  private

  # Placeholder for proper encryption
  def encrypt(value)
    return '{}' if value.nil?
    value + '!'
  end

  def decrypt(value)
    return '{}' if value.nil?
    value.first(value.length - 1)
  end
end
