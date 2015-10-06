class AllocationWeightsApi < Grape::API
  desc 'Get a list of allocation_weights'
  params do
    optional :ids, type: Array, desc: 'Array of allocation_weight ids'
  end
  get do
    allocation_weights = params[:ids] ? AllocationWeight.where(id: params[:ids]) : AllocationWeight.all
    represent allocation_weights, with: AllocationWeightRepresenter
  end

  desc 'Create an allocation_weight'
  params do
  end

  post do
    allocation_weight = AllocationWeight.create!(permitted_params)
    represent allocation_weight, with: AllocationWeightRepresenter
  end

  params do
    requires :id, desc: 'ID of the allocation_weight'
  end
  route_param :id do
    desc 'Get an allocation_weight'
    get do
      allocation_weight = AllocationWeight.find(params[:id])
      represent allocation_weight, with: AllocationWeightRepresenter
    end

    desc 'Update an allocation_weight'
    params do
    end
    put do
      # fetch allocation_weight record and update attributes.  exceptions caught in app.rb
      allocation_weight = AllocationWeight.find(params[:id])
      allocation_weight.update_attributes!(permitted_params)
      represent allocation_weight, with: AllocationWeightRepresenter
    end
  end
end
