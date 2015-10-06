require 'spec_helper'

def app
  ApplicationApi
end

describe AllocationWeightsApi do
  include Rack::Test::Methods

  it 'gets a list' do
    FactoryGirl.create_list(:allocation_weight, 2)

    get '/allocation_weights'
    json = JSON.parse(last_response.body)

    expect(last_response.status).to eq(200)
    expect(json['data'].length).to eq(2)
  end

  it 'gets a list by tolerance level' do
    aw = FactoryGirl.create_list(:allocation_weight, 2)
    aw_tl = aw.first.tolerance_level
    
    get "/allocation_weights?tolerance_level=#{aw_tl}"

    json = JSON.parse(last_response.body)
    expect(last_response.status).to eq(200)
    expect(json['data'].length).to eq(1)
  end
end