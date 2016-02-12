require 'spec_helper'

describe Appilf::DomainTrait do
  include Appilf::TestData

  describe '.new' do
    let(:domain_trait) do
      Appilf::DomainTrait.new(load_test_json_data(mocked_response_file_path('client/domain_trait/domain_trait.json')))
    end

    it 'should respond to id' do
      domain_trait.id.should == 'verified'
    end

  end

end