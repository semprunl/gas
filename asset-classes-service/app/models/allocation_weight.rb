class AllocationWeight < ActiveRecord::Base
  belongs_to :asset_class
  validates :asset_class, :weight, :tolerance_level, presence: true
  validates :tolerance_level, uniqueness: { scope: :asset_class,
    message: "should be unique per asset class" }
end