class AssetClass < ActiveRecord::Base
  has_many :allocation_weights
  validates :name, uniqueness: true, presence: true
end
