module V1
  class Categories < Grape::API
    before do
      error!("401 Unauthorized", 401) unless authenticated
    end

    resource :categories do
      desc "分类",
        is_array: true,
        http_codes: [
          [200, '成功', V1::Entities::Category],
          [401, '未授权', V1::Entities::Error]
        ]
      params do
        optional 'X-Access-Token', type: String, desc: 'Token', documentation: { in: :header }
      end
      get do
        present Category.all, with: V1::Entities::Category
      end
    end
  end
end
