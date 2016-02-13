require 'spec_helper'

describe Appilf::SavedSearch do
  include Appilf::TestData

  describe '.new' do
    let(:saved_search) do
      Appilf::DomainTrait.new(load_test_json_data(mocked_response_file_path('client/saved_search/saved_search.json')))
    end

    it 'should respond to id' do
      saved_search.id.should == '789'
    end

    it 'should respond to name' do
      saved_search.name.should == 'below $500'
    end

  end

end