require 'spec_helper'

describe Appilf::User do
  include Appilf::TestData

  describe '.new' do
    let(:user) { Appilf::User.new(load_test_json_data(mocked_response_file_path('client/users/user.json'))) }

    it 'should respond to id' do
      user.id.should == 123
    end

    it 'should respond to username' do
      user.username.should == "superdog@somedog.com"
    end

    it 'should respond to full_name' do
      user.full_name.should == "Mr. Super Dog"
    end

    it 'should respond to is_admin' do
      user.is_admin.should == false
    end
  end


end