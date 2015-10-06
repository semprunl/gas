class ApplicationApi < Grape::API
  format :json
  extend Napa::GrapeExtenders

  mount AssetClassesApi => '/asset_classes'
  mount AllocationWeightsApi => '/allocation_weights'
  
  add_swagger_documentation
end