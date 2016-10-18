# The decrypter cipher takes an initialisation vector (iv) value when initialized, and is then able to decrypt strings
# using the `apply` method.
# Example usage:
#
# cipher = Cipher::Decrypter.new(stored_data[:iv])
# decrypted_data = cipher.apply(stored_data[:encrypted_data])
# => 'Some input text'

class Cipher
  class Decrypter < Cipher
    def initialize(iv)
      cipher.iv = iv
    end

    private

    def cipher_mode
      :decrypt
    end
  end
end
