class Cipher
  def apply(string)
    cipher.update(string) << cipher.final
  end

  private

  def cipher
    @cipher ||= OpenSSL::Cipher::Cipher.new(cipher_algorithm).tap do |open_ssl_cipher|
      open_ssl_cipher.send(cipher_mode)
      open_ssl_cipher.key = Digest::SHA1.hexdigest(cipher_key_base)
    end
  end

  def cipher_algorithm
    'aes-256-cbc'
  end

  def cipher_key_base
    Rails.application.secrets[:cipher_key_base]
  end
end
