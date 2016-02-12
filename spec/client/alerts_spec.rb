require 'spec_helper'

describe Appilf::Client do
  include Appilf::TestData
  let(:client) { authenticated_client }
  before { stub_identity_request }

  describe '.list_alerts' do
    let(:alerts) { client.list_alerts }
    before { stub_api_get_request("#{client.authenticated_user_path}#{Appilf::Client::Alerts::PATH}", 'client/alerts/alerts.json') }

    it 'should return a generic Appilf::AppilfObject instance' do
      alerts.class.should == Appilf::AppilfObject
    end

    it 'should contain respond to meta.pending_bids_count' do
      alerts.meta.pending_bids_count.should == 1
    end

    it 'should contain respond to meta.pending_bids_count' do
      alerts.meta.pending_offers_count.should == 2
    end

    it 'should contain respond to meta.pending_bids_count' do
      alerts.meta.unread_messages_count.should == 5
    end

  end

end