FactoryGirl.define do
  factory :asset_class do
    sequence(:name) { |n| "Asset Class #{n}" }

    factory :asset_class_with_allocation_weights do
      transient do
        aw_count 8
      end

      after(:create) do |asset_class, evaluator|
        create_list(:allocation_weight, evaluator.aw_count, asset_class: asset_class)
      end
    end
  end
end