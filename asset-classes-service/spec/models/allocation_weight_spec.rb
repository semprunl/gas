require 'spec_helper'

describe AllocationWeight do

  it 'can be created' do
    allocation_weight = create :allocation_weight
    expect(allocation_weight).to_not be_nil
  end

  it 'is invalid without an asset class' do
    expect(build(:allocation_weight, asset_class: nil)).to be_invalid
  end

  it 'is invalid without a weight' do
    expect(build(:allocation_weight, weight: nil)).to be_invalid
  end

  it 'is invalid without a tolerance level' do
    expect(build(:allocation_weight, tolerance_level: nil)).to be_invalid
  end

  it 'is invalid with a duplicate tolerance level within the asset class scope' do
    ac = create :allocation_weight
    expect(build(
      :allocation_weight,
      asset_class: ac.asset_class,
      tolerance_level: ac.tolerance_level,
      weight: 1
    )).to be_invalid
  end
end
