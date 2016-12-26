require 'spec_helper'

RSpec.describe 'Cipher' do
  it 'cipher classes can encrypt, and then decrypt a string' do
    source_string = 'Hey! This is a secret message.'

    encrypter = Cipher::Encrypter.new
    iv = encrypter.iv
    encrypted_string = encrypter.apply(source_string)

    decrypter = Cipher::Decrypter.new(iv)
    decrypted_string = decrypter.apply(encrypted_string)

    expect(decrypted_string).to eq(source_string)
  end
end
