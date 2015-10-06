require 'spec_helper'

def app
  ApplicationApi
end

describe 'README' do
  include Rack::Test::Methods

  context 'swagger documentation root' do
    before do
      get '/swagger_doc'
      expect(last_response.status).to eq(200)
      @json = JSON.parse(last_response.body)
    end

    it 'exposes api version' do
      expect(@json['apiVersion']).to eq('0.1')
      expect(@json['apis'].size).to be > 2
    end
  end

  context 'swagger documentation api' do
    before do
      get '/swagger_doc'
      expect(last_response.status).to eq(200)
      @apis = JSON.parse(last_response.body)['apis']
    end
  end
end
