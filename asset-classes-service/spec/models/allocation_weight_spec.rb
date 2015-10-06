require 'spec_helper'

describe AllocationWeight do

  it 'can be created' do
    allocation_weight = create :allocation_weight
    expect(allocation_weight).to_not be_nil
  end

  it 'needs tests to be written!' do
    pending('write tests for AllocationWeight!')
  end

end
