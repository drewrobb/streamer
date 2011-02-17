require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

class FakeController
  include Streamer
  attr_accessor :headers
  attr_accessor :response_body
  def initialize
    @headers = {}
  end
end

describe Streamer do

  describe '#stream_to' do

    before do
      @controller = FakeController.new
      @controller.stream_to('test_file_name.txt') do |output|
        output.write('Some data to stream to the client...')
      end
    end

    it 'set the content type header to text/plain' do
      @controller.headers["Content-Type"].should == "text/plain"
    end

    it 'set the content type header to text/plain' do
      @controller.headers["Content-disposition"].should == "attachment; filename=\"test_file_name.txt\""
    end

    it 'should set the response body to a proc which yields the output stream' do
      body = @controller.response_body
      body.is_a?(Proc).should be_true
      mock_response = mock
      mock_response.expects(:write).with('Some data to stream to the client...')
      body.call(mock, mock_response)
    end

    it 'should ignore the erroneous second call to the response proc' do
      body = @controller.response_body
      mock_response = mock
      mock_response.expects(:write).with('Some data to stream to the client...')
      body.call(mock, mock_response)
      body.call(mock, mock_response)
    end
  end

  describe '#stream_json' do
    before do
      @controller = FakeController.new
    end

    it 'set the content type header to application/json' do
      @controller.stream_json
      @controller.headers["Content-Type"].should == "application/json"
    end

    describe 'for two mock objects' do

      before do
        (value1 = mock).expects(:to_json).returns('JSON_FOR_VALUE1')
        (value2 = mock).expects(:to_json).returns('JSON_FOR_VALUE2')
        @controller.stream_json do |output|
          [value1, value2].each do |value|
            @controller.send_record(value)
          end
        end
        @mock_response = mock
        @mock_response.expects(:write).with('[')
        @mock_response.expects(:write).with("JSON_FOR_VALUE1")
        @mock_response.expects(:write).with(",")
        @mock_response.expects(:write).with("JSON_FOR_VALUE2")
        @mock_response.expects(:write).with(']')
      end

      it 'should set the response body to a proc which yields the given values as json' do
        body = @controller.response_body
        body.is_a?(Proc).should be_true
        body.call(mock, @mock_response)
      end

      it 'should ignore the erroneous second call to the response proc' do
        body = @controller.response_body
        body.call(mock, @mock_response)
        body.call(mock, @mock_response)
      end
    end
  end
end
