# When we encrypt a string, we generate a random IV (initialisation vector) that is needed to decrypt the resulting
# string. This IV should be stored with the encrypted string to facilitate decryption.
# Example usage:
#
# cipher = Cipher::Encrypter.new
# stored_data[:encrypted_data] = cipher.apply('Some input text')
# stored_data[:iv] = cipher.iv

class Cipher
  class Encrypter < Cipher
    def initialize
      cipher.iv = iv
    end

    def iv
      @iv ||= cipher.random_iv
    end

    private

    def cipher_mode
      :encrypt
    end
  end
end
