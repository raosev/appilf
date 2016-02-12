require 'spec_helper'

describe Appilf::Client do
  include Appilf::TestData
  let(:client) {  authenticated_client }
  before {  stub_identity_request  }

  describe '.retrieve_user' do
    let(:user) { client.retrieve_user(123) }
    before { stub_api_get_request("#{Appilf::Client::Users::PATH}/123", 'client/users/user.json') }

    it 'should return an User entry' do
      user.class.should == Appilf::User
    end

  end

end