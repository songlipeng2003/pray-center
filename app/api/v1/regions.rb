module V1
  class Regions < Grape::API
    resource :regions do
      desc "区域",
        is_array: true,
        http_codes: [
          [200, '成功', V1::Entities::Region],
          # [401, '未授权', V1::Entities::Error]
        ]
      params do
        # optional 'X-Access-Token', type: String, desc: 'Token', documentation: { in: :header }
      end
      get do
        present Region.all, with: V1::Entities::Region
      end
    end
  end
end
