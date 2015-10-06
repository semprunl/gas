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
    end
    put do
      # fetch asset_class record and update attributes.  exceptions caught in app.rb
      asset_class = AssetClass.find(params[:id])
      asset_class.update_attributes!(permitted_params)
      represent asset_class, with: AssetClassRepresenter
    end
  end
end
