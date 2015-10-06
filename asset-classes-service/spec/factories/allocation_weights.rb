FactoryGirl.define do
  factory :allocation_weight do
    asset_class
    sequence(:tolerance_level)
    weight 9.99
  end
end
