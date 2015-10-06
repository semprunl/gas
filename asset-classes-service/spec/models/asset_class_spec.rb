require 'spec_helper'

describe AssetClass do

  it 'can be created' do
    asset_class = create :asset_class
    expect(asset_class).to_not be_nil
  end

  it 'is invalid without a name' do
    expect(build(:asset_class, name: nil)).to be_invalid
  end

  it 'is invalid with a duplicate name' do
    ac = create :asset_class
    expect(build(:asset_class, name: ac.name)).to be_invalid
  end

end
