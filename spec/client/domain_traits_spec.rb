require 'spec_helper'

describe Appilf::Client do
  include Appilf::TestData
  let(:client) {  authenticated_client }
  before {  stub_identity_request  }

  describe '.list_domain_traits' do
    let(:domain_traits) { client.list_domain_traits(123) }
    before do
      stub_api_get_request("#{Appilf::Listing.listing_path(123)}#{Appilf::Client::DomainTraits::PATH}",
                           'client/domain_trait/domain_traits.json')
    end

    it 'should return an Array of Appilf::DomainTrait' do
      domain_traits.class.should == Array
      domain_traits.all?{ |domain_trait| domain_trait.class.should == Appilf::DomainTrait  }.should be_truthy
    end

  end

end