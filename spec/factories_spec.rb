require 'rails_helper'

FactoryGirl.factories.map(&:name).each do |factory_name|
  describe "The #{factory_name} factory" do
    it 'is valid' do
      factory = FactoryGirl.build(factory_name)
      factory.valid?
      expect(factory.errors).to be_empty
    end
  end
end
