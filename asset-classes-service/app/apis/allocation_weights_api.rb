class AllocationWeightsApi < Grape::API
  desc 'Get a list of allocation_weights'
  params do
    optional :tolerance_level, type: Integer, desc: 'Tolerance Level of the user'
  end
  get do
    allocation_weights = params[:tolerance_level] ? AllocationWeight.where(tolerance_level: params[:tolerance_level]) : AllocationWeight.all
    represent allocation_weights, with: AllocationWeightRepresenter
  end
end
