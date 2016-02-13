require 'spec_helper'

describe Appilf::Client do
  include Appilf::TestData
  let(:client) { authenticated_client }
  before {  stub_identity_request  }

  describe '.list_saved_searches' do
    let(:saved_searches) { client.list_saved_searches }
    before do
      stub_api_get_request(client.saved_searches_path,
                           'client/saved_search/saved_searches.json')
    end

    it 'should return a Appilf::ResourcePage' do
      saved_searches.class.should == Appilf::ResourcePage
    end

    specify 'all entries should be of type Appilf::SavedSearch' do
      saved_searches.all?{ |saved_search| saved_search.class.should == Appilf::SavedSearch  }.should be_truthy
    end
  end

  describe '.delete_saved_search' do
    let(:response) { client.delete_saved_search(123) }
    before do
      stub_api_delete_request(client.saved_searches_path(123))
    end

    it 'should return :success' do
      response.should == :success
    end
  end

end