require 'spec_helper'

describe AssetClass do

  it 'can be created' do
    asset_class = create :asset_class
    expect(asset_class).to_not be_nil
  end

  it 'needs tests to be written!' do
    pending('write tests for AssetClass!')
  end

end
