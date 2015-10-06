require 'spec_helper'

def app
  ApplicationApi
end

describe AssetClassesApi do
  include Rack::Test::Methods

  context '/asset_classes' do
    it 'gets a list' do
      FactoryGirl.create_list(:asset_class, 2)
      get '/asset_classes'

      json = JSON.parse(last_response.body)
      expect(last_response.status).to eq(200)
      expect(json['data'].length).to eq(2)
    end

    it 'gets a list by ids' do
      ac = FactoryGirl.create_list(:asset_class, 3)
      get "/asset_classes?ids[]=#{ac.first.id}&ids[]=#{ac.last.id}"

      json = JSON.parse(last_response.body)
      expect(last_response.status).to eq(200)
      expect(json['data'].length).to eq(2)
    end

    it 'gets a single record' do
      ac = FactoryGirl.create(:asset_class)
      get "/asset_classes/#{ac.id}"
      
      json = JSON.parse(last_response.body)
      expect(last_response.status).to eq(200)
      expect(json['data']['name']).to eq(ac.name)
    end

    it 'creates single record' do
      an = "#{Random.rand}"
      post '/asset_classes', 'name' => an

      json = JSON.parse(last_response.body)
      expect(last_response.status).to eq(201)
      expect(json['data']['name']).to eq(an)
    end

    it 'updates a record' do
      ac = FactoryGirl.create(:asset_class)
      nm = "#{Random.rand}"
      put "/asset_classes/#{ac.id}", 'name' => nm

      json = JSON.parse(last_response.body)
      expect(last_response.status).to eq(200)
      expect(json['data']['name']).to eq(nm)
    end
  end

  context '/asset_classes/{id}/allocation_weights' do
    it 'gets a list from an asset class' do
      ac = FactoryGirl.create(:asset_class_with_allocation_weights, aw_count: 2)
      get "/asset_classes/#{ac.id}/allocation_weights"

      json = JSON.parse(last_response.body)
      expect(last_response.status).to eq(200)
      expect(json['data'].length).to eq(2)
    end

    it 'gets an asset class\'s allocation weight by tolerance level' do
      ac = FactoryGirl.create(:asset_class_with_allocation_weights, aw_count: 2)
      aw_tl = ac.allocation_weights.first.tolerance_level
      get "/asset_classes/#{ac.id}/allocation_weights?tolerance_level=#{aw_tl}"

      json = JSON.parse(last_response.body)
      expect(last_response.status).to eq(200)
      expect(json['data']['tolerance_level']).to eq(aw_tl)
    end

    it 'creates single record' do
      ac = FactoryGirl.create(:asset_class)
      post "/asset_classes/#{ac.id}/allocation_weights", 'weight' => 10, 'tolerance_level' => 1 

      json = JSON.parse(last_response.body)
      expect(last_response.status).to eq(201)
      expect(json['data']).to eq(
        'object_type' => 'allocation_weight', 'tolerance_level' => 1, 'weight' => 10
      )
    end

    it 'updates a record' do
      ac = FactoryGirl.create(:allocation_weight)
      put "/asset_classes/#{ac.asset_class.id}/allocation_weights", { 
        'tolerance_level' => ac.tolerance_level, 'weight' => ac.weight.pred
      }

      json = JSON.parse(last_response.body)
      expect(last_response.status).to eq(200)
      expect(json['data']).to eq(
        'object_type' => 'allocation_weight',
        'tolerance_level' => ac.tolerance_level,
        'weight' => ac.weight.pred
      )
    end
  end
end