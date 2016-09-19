module V1
  class Prays < Grape::API
    before do
      error!("401 Unauthorized", 401) unless authenticated
    end

    resource :prays do
      desc '用户发出代祷列表',
        is_array: true,
        http_codes: [
          [201, '成功', V1::Entities::PrayHistory],
          [401, '未授权', V1::Entities::Error],
        ]
      paginate per_page: 10, max_per_page: 200
      params do
        optional 'X-Access-Token', type: String, desc: 'Token', documentation: { in: :header }
        optional :page, type: Integer, default: 1, desc: "页码"
        optional :per_page, type: Integer, default: 10, desc: '每页数量'
      end
      get do
        result = paginate current_user.pray_histories

        present result, with: V1::Entities::PrayHistory
      end

      desc '用户收到的代祷列表',
        is_array: true,
        http_codes: [
          [201, '成功', V1::Entities::PrayHistory],
          [401, '未授权', V1::Entities::Error],
        ]
      paginate per_page: 10, max_per_page: 200
      params do
        optional 'X-Access-Token', type: String, desc: 'Token', documentation: { in: :header }
        optional :page, type: Integer, default: 1, desc: "页码"
        optional :per_page, type: Integer, default: 10, desc: '每页数量'
      end
      get :receive do
        query = PrayHistory.joins(:post).where(posts: { user_id: current_user.id })
        result = paginate query

        present result, with: V1::Entities::PrayHistory
      end

      desc "代祷",
        http_codes: [
          [201, '成功', V1::Entities::PrayHistory],
          [401, '未授权', V1::Entities::Error],
          [403, '没有权限', V1::Entities::Error],
          [404, 'Not Found', V1::Entities::Error],
          [422, '错误', V1::Entities::Error]
        ]
      params do
        optional 'X-Access-Token', type: String, desc: 'Token', documentation: { in: :header }
        requires :post_id, type: Integer, desc: "帖子编号"
      end
      post do
        check_user_info!

        post = current_user.posts.find(params[:post_id])

        pray_history = PrayHistory.where(user_id: current_user.id, post_id: params[:id]).first

        if pray_history
          error!('已经代祷，不能重复代祷', 422)
        end

        pray_history = PrayHistory.create!(user_id: current_user.id, post_id: params[:id])

        present pray_history, with: V1::Entities::PrayHistory
      end

      desc '感谢代祷',
        http_codes: [
          [201, '成功', V1::Entities::PrayHistory],
          [401, '未授权', V1::Entities::Error],
          [403, '没有权限', V1::Entities::Error],
          [404, 'Not Found', V1::Entities::Error],
          [422, '错误', V1::Entities::Error]
        ]
      params do
        optional 'X-Access-Token', type: String, desc: 'Token', documentation: { in: :header }
        requires :history_id, type: Integer, desc: "编号"
      end
      route_param :history_id do
        put :thank do
          check_user_info!

          pray_history = PrayHistory.find(params[:history_id])

          if pray_history.post.user!=current_user
            error!('Not Found', 404)
          end

          if pray_history.is_thanked
            error!('已经感谢代祷，不能重复感谢代祷', 422)
          end
          pray_history.is_thanked = true
          pray_history.save

          present pray_history, with: V1::Entities::PrayHistory
        end
      end

      desc '批量感谢代祷',
        http_codes: [
          [201, '成功', V1::Entities::Result],
          [401, '未授权', V1::Entities::Error],
          [403, '没有权限', V1::Entities::Error],
          [422, '错误', V1::Entities::Error]
        ]
      params do
        optional 'X-Access-Token', type: String, desc: 'Token', documentation: { in: :header }
      end
      post :batch_thank do
        check_user_info!

        PrayHistory.joins(:post).where(posts: { user_id: current_user.id }).update_all is_thanked: true

        { result: true }
      end
    end
  end
end
