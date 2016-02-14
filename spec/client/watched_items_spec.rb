require 'spec_helper'

describe Appilf::Client do
  include Appilf::TestData
  let(:client) { authenticated_client }
  before { stub_identity_request }

  describe '.create_watched_item' do
    let(:watched_item) { client.create_watched_item('listing', 123) }
    before { stub_api_post_request(client.watched_items_path,
                                   'client/watched_item.json',
                                   200,
                                   {item_type: 'listing', item_id: '123'}) }

    it 'should return an Appilf::WatchedItem instance' do
      watched_item.class.should == Appilf::WatchedItem
    end

    it 'should respond to id' do
      watched_item.id.should == '789'
    end

    specify '.watcher should return an Appilf::User instance' do
      watched_item.watcher.class.should == Appilf::User
    end

    it '.item should return an Appilf::Listing instance' do
       watched_item.item.class.should == Appilf::Listing
    end
  end

  describe '.delete_watched_item' do
    let(:response) { client.delete_watched_item('listing', 123) }
    before { stub_api_delete_request(client.watched_items_path,
                                     {item_type: 'listing', item_id: '123'}) }

    it 'should return :success' do
      response.should == :success
    end
  end

end