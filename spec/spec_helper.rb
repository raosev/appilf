require 'coveralls'
Coveralls.wear!

require 'pry'
require 'appilf'
require 'webmock/rspec'
WebMock.disable_net_connect!

module Appilf

  module TestData

    def stub_api_get_request(api_path, mocked_response_file, code = 200, query_params = {})
      stub_request(:get, api_path).
          with(query: query_params).
          to_return(body: load_test_data(mocked_response_file_path(mocked_response_file)),
               status: code)
    end

    def stub_api_post_request(api_path, mocked_response, code = 200, request_body = {})
      stub_request(:post, api_path).
          with(body: request_body).
          to_return(body: load_test_data(mocked_response_file_path(mocked_response)),
                    status: code)
    end

    def load_test_data(mocked_response_path)
      File.read(mocked_response_path)
    end

    def load_test_json_data(mocked_response_path)
      JSON.parse(File.read(mocked_response_path))
    end

    def mocked_response_file_path(path)
      "spec/mocked_responses/#{path}"
    end


  end

end