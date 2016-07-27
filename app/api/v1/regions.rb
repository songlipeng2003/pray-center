module V1
  class Regions < Grape::API
    before do
      error!("401 Unauthorized", 401) unless authenticated
    end

    resource :regions do
      desc "区域",
        is_array: true,
        http_codes: [
         [200, '成功', V1::Entities::Region]
        ]
      params do
        optional 'X-Access-Token', type: String, desc: 'Token', documentation: { in: :header }
      end
      get do
        present Region.all, with: V1::Entities::Region
      end
    end
  end
end
