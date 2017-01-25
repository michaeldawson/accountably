# Take in an ordinary hash, and store it in the database in an encrypted form. Store both the encrypted data, and the
# initialization vector (iv) for the Cipher that is needed to decrypt the data. When deserialized, wrap the data up in a
# HiddenHash to obscure it (trivially!) from inspection.

require_dependency 'hidden_hash'

class EncryptedHashType < ActiveRecord::Type::Value
  def serialize(value)
    return nil if value.blank?

    cipher = Cipher::Encrypter.new
    cipher_iv = ascii8_to_utf8(cipher.iv)
    encrypted_data = ascii8_to_utf8(cipher.apply(value.to_json))

    {
      iv: cipher_iv,
      data: encrypted_data
    }.to_json
  end

  def deserialize(value)
    return nil if value.blank?

    raw = JSON.parse(value)
    cipher_iv = utf8_to_ascii_8(raw['iv'])
    encrypted_data = utf8_to_ascii_8(raw['data'])

    cipher = Cipher::Decrypter.new(cipher_iv)
    decrypted_data = cipher.apply(encrypted_data)

    hash = JSON.parse(decrypted_data).deep_symbolize_keys
    HiddenHash.new_from_hash(hash)
  end

  def cast(value)
    HiddenHash.new_from_hash(value.deep_symbolize_keys)
  end

  private

  def ascii8_to_utf8(data)
    Base64.encode64(data).encode('utf-8')
  end

  def utf8_to_ascii_8(data)
    Base64.decode64(data.encode('ascii-8bit'))
  end
end
