require 'spec_helper'

describe Appilf::Client do
  include Appilf::TestData
  let(:client) { authenticated_client }
  before {  stub_identity_request  }

  describe '.list_saved_searches' do
    let(:saved_searches) { client.list_saved_searches }
    before do
      stub_api_get_request("#{client.authenticated_user_path}#{Appilf::Client::SavedSearches::PATH}",
                           'client/saved_search/saved_searches.json')
    end

    it 'should return a Appilf::ResourcePage' do
      saved_searches.class.should == Appilf::ResourcePage
    end

    specify 'all entries should be of type Appilf::SavedSearch' do
      saved_searches.all?{ |saved_search| saved_search.class.should == Appilf::SavedSearch  }.should be_truthy
    end


  end

end