require 'spec_helper'

describe Appilf::Client do
  include Appilf::TestData

  describe '.new' do

    context 'using password grant' do
      let(:creds) { {username: 'superdog@somedog.com', password: '123456'} }
      before { stub_api_get_request("#{Appilf::Client::Users::PATH}/identify", 'client/user.json') }

      context 'using correct credentials' do
        let(:client) { Appilf::Client.new(creds) }
        before do
          stub_api_post_request(Appilf::Authentication::PATH,
                                'client/authentication_token.json',
                                200,
                                creds.merge(grant_type: 'password'))
        end

        it 'should return an authenticated client' do
          client.access_token.should == "6a853b20a67d41fc199e635071e45a7cf3fff927"
        end

        it 'should store a reference to the authenticated user' do
          client.user.id.should == 123
        end
      end

      context 'using wrong credentials' do
        before do
          stub_api_post_request(Appilf::Authentication::PATH,
                                'client/authentication_token.json',
                                400,
                                creds.merge(grant_type: 'password'))
        end

        it 'should return an authenticated client' do
          expect { Appilf::Client.new(creds) }.to raise_error(Appilf::BadRequest)
        end
      end
    end

    context 'initializing with token directly' do
      let(:client) { Appilf::Client.new(access_token: "6a853b20a67d41fc199e635071e45a7cf3fff927") }
      before { stub_api_get_request("#{Appilf::Client::Users::PATH}/identify", 'client/user.json') }

      it 'should store the access token' do
        client.access_token.should == "6a853b20a67d41fc199e635071e45a7cf3fff927"
      end

      it 'should store a reference to the authenticated user' do
        client.user.id.should == 123
      end
    end

  end
end