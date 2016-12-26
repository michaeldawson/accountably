require 'spec_helper'

FactoryGirl.factories.each do |factory|
  next if factory.instance_variable_get(:@aliases).include?(:skip_validation)

  describe "The #{factory.name} factory" do
    it 'is valid' do
      factory_instance = FactoryGirl.build(factory.name)
      factory_instance.valid?
      expect(factory_instance.errors).to be_empty
    end
  end
end
