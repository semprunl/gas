class AssetClassesApi < Grape::API
  desc 'Get a list of asset_classes'
  params do
    optional :ids, type: Array, desc: 'Array of asset_class ids'
  end
  get do
    asset_classes = params[:ids] ? AssetClass.where(id: params[:ids]) : AssetClass.all
    represent asset_classes, with: AssetClassRepresenter
  end

  desc 'Create an asset_class'
  params do
    requires :name, type: String, desc: 'The Name of the asset class'
  end
  post do
    asset_class = AssetClass.create!(permitted_params)
    represent asset_class, with: AssetClassRepresenter
  end

  params do
    requires :id, desc: 'ID of the asset_class'
  end
  route_param :id do
    desc 'Get an asset_class'
    get do
      asset_class = AssetClass.find(params[:id])
      represent asset_class, with: AssetClassRepresenter
    end

    desc 'Update an asset_class'
    params do
      optional :name, type: String, desc: 'The Name of the asset class'
    end
    put do
      asset_class = AssetClass.find(params[:id])
      asset_class.update_attributes!(permitted_params)
      represent asset_class, with: AssetClassRepresenter
    end

    resource :allocation_weights do
      desc 'Create an allocation_weight'
      params do
        requires :tolerance_level, type: Integer, desc: 'The Tolerance Level of the user'
        requires :weight, type: BigDecimal, desc: 'The Weight of the asset class for the Tolerance Level'
      end
      post do
        allocation_weight = AssetClass.find(params[:id]).allocation_weights.create!(permitted_params.except(:id))
        represent allocation_weight, with: AllocationWeightRepresenter
      end

      desc 'Get a list of allocation_weights or one by tolerance_level'
      params do
        optional :tolerance_level, type: Integer, desc: 'Tolerance Level of the user'
      end
      get do
        ac = AssetClass.find(params[:id])
        allocation_weights = params[:tolerance_level] ? ac.allocation_weights.find_by!(tolerance_level: params[:tolerance_level]) \
          : ac.allocation_weights
        represent allocation_weights, with: AllocationWeightRepresenter
      end

      desc 'Update an allocation_weight'
      params do
        requires :tolerance_level, type: Integer, desc: 'The Tolerance Level of the user'
        requires :weight, type: BigDecimal, desc: 'The Weight of the asset class for the Tolerance Level'
      end
      put do
        allocation_weight = AssetClass.find(params[:id]).allocation_weights.find_by!(tolerance_level: params[:tolerance_level])
        allocation_weight.update_attributes!(permitted_params.except(:id))
        represent allocation_weight, with: AllocationWeightRepresenter
      end
    end
  end
end
