module V1
  class Posts < Grape::API

    resource :posts do
      desc "帖子列表",
        is_array: true,
        http_codes: [
          [200, '成功', V1::Entities::Post],
          [401, '未授权', V1::Entities::Error]
        ]
      paginate per_page: 10, max_per_page: 200
      params do
        optional 'X-Access-Token', type: String, desc: 'Token', documentation: { in: :header }
        optional :category_id, type: Integer, desc: '分类'
        optional :region_id, type: Integer, desc: '区域'
        optional :sort, type: String, values: ['id', 'pray_number'], default: 'id', desc: '排序字段'
        optional :order, type: String, values: ['desc', 'asc'], default: 'desc', desc: '排列方式'
        optional :page, type: Integer, default: 1, desc: "页码"
        optional :per_page, type: Integer, default: 10, desc: '每页数量'
      end
      get do
        authenticate!

        query = Post.includes(:category, :region).where('1=1')
        query = query.where(category_id: params[:category_id]) if params[:category_id]
        query = query.where(region_id: params[:region_id]) if params[:region_id]
        query = query.order(params[:sort] => params[:order])
        result = paginate query

        present result, with: V1::Entities::Post, user: current_user
      end

      desc "帖子详情",
        http_codes: [
          [200, 'Ok', V1::Entities::Post],
          [401, '未授权', V1::Entities::Error]
        ]
      params do
        requires :id, type: Integer, desc: "编号"
      end
      route_param :id do
        get do
          present Post.find(params[:id]), with: V1::Entities::Post, user: current_user
        end
      end

      desc "添加帖子",
        http_codes: [
          [201, '成功', V1::Entities::Post],
          [401, '未授权', V1::Entities::Error],
          [403, '没有权限', V1::Entities::Error],
          [422, '错误', V1::Entities::Error]
        ]
      params do
        optional 'X-Access-Token', type: String, desc: 'Token', documentation: { in: :header }
        requires :category_id, type: Integer, desc: "分类"
        requires :region_id, type: Integer, desc: "区域"
        requires :title, type: String, desc: "标题"
        requires :content, type: String, desc: "内容"
      end
      post do
        authenticate!
        check_user_info!

        if current_user.pray_histories.count<0
          error!('代祷少于7次不能发布', 422)
        end

        safe_params = clean_params(params).permit(:title, :content, :category_id, :region_id)
        post = current_user.posts.new(safe_params)
        # post.application = current_application
        if post.save
          present post, with: V1::Entities::Post, user: current_user
        else
          error!(post.errors.full_messages.first, 422)
        end
      end

      desc "编辑帖子",
        http_codes: [
          [201, '成功', V1::Entities::Post],
          [401, '未授权', V1::Entities::Error],
          [403, '没有权限', V1::Entities::Error],
          [404, 'Not Found', V1::Entities::Error],
          [422, '错误', V1::Entities::Error]
        ]
      params do
        optional 'X-Access-Token', type: String, desc: 'Token', documentation: { in: :header }
        requires :id, type: Integer, desc: "编号"
        requires :title, type: String, desc: "标题"
        requires :content, type: String, desc: "内容"
      end
      route_param :id do
        put do
          authenticate!
          check_user_info!

          post = current_user.posts.find(params[:id])
          safe_params = clean_params(params).permit(:title, :content)
          if post.update(safe_params)
            present post, with: V1::Entities::Post, user: current_user
          else
            error!(post.errors.full_messages.first, 422)
          end
        end
      end

      desc "添加帖子图片",
        http_codes: [
          [201, '成功', V1::Entities::PostImage],
          [401, '未授权', V1::Entities::Error],
          [403, '没有权限', V1::Entities::Error],
          [404, 'Not Found', V1::Entities::Error],
          [422, '错误', V1::Entities::Error]
        ]
      params do
        optional 'X-Access-Token', type: String, desc: 'Token', documentation: { in: :header }
        requires :id, type: Integer, desc: "编号"
        requires :image, type: File, desc: "图片"
      end
      route_param :id do
        post :images do
          authenticate!
          check_user_info!

          post = current_user.posts.find(params[:id])

          post_image = post.post_images.new
          post_image.image = params[:image]
          if post_image.save
            present post_image, with: V1::Entities::PostImage
          else
            error!(post_image.errors.full_messages.first, 422)
          end
        end
      end

      desc "删除帖子",
        http_codes: [
          [204, '成功'],
          [401, '未授权', V1::Entities::Error],
          [403, '没有权限', V1::Entities::Error],
          [404, 'Not Found', V1::Entities::Error],
        ]
      params do
        optional 'X-Access-Token', type: String, desc: 'Token', documentation: { in: :header }
        requires :id, type: Integer, desc: "编号"
      end
      route_param :id do
        delete do
          authenticate!

          post = current_user.posts.find(params[:id])
          post.destroy
          status 204
          # { code: 0 }
        end
      end

      desc "代祷",
        http_codes: [
          [201, '成功', V1::Entities::Post],
          [401, '未授权', V1::Entities::Error],
          [403, '没有权限', V1::Entities::Error],
          [404, 'Not Found', V1::Entities::Error],
          [422, '错误', V1::Entities::Error]
        ]
      params do
        optional 'X-Access-Token', type: String, desc: 'Token', documentation: { in: :header }
        requires :id, type: Integer, desc: "帖子编码"
      end
      route_param :id do
        put :pray do
          authenticate!
          check_user_info!

          post = Post.find(params[:id])

          pray_history = PrayHistory.where(user_id: current_user.id, post_id: params[:id]).first

          if pray_history
            error!('已经代祷，不能重复代祷', 422)
          end

          pray_history = PrayHistory.create!(user_id: current_user.id, post_id: params[:id])

          post.reload

          present post, with: V1::Entities::Post, user: current_user
        end
      end

      params do
        requires :id, type: Integer, desc: "帖子编码"
      end
      namespace ':id' do
        namespace :prays do
          desc '代祷列表',
            http_codes: [
              [201, '成功', V1::Entities::PrayHistory],
              [401, '未授权', V1::Entities::Error],
              [404, 'Not Found', V1::Entities::Error],
            ]
          paginate per_page: 10, max_per_page: 200
          params do
            optional 'X-Access-Token', type: String, desc: 'Token', documentation: { in: :header }
            optional :page, type: Integer, default: 1, desc: "页码"
            optional :per_page, type: Integer, default: 10, desc: '每页数量'
          end
          get do
            authenticate!

            post = Post.find(params[:id])

            result = paginate post.pray_histories

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
          end
          post do
            authenticate!
            check_user_info!

            post = Post.find(params[:id])

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
              authenticate!
              check_user_info!

              post = current_user.posts.find(params[:id])
              pray_history = post.pray_histories.find(params[:history_id])
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
              [404, 'Not Found', V1::Entities::Error],
              [422, '错误', V1::Entities::Error]
            ]
          params do
            optional 'X-Access-Token', type: String, desc: 'Token', documentation: { in: :header }
          end
          post :batch_thank do
            authenticate!
            check_user_info!

            post = current_user.posts.find(params[:id])
            post.pray_histories.update_all is_thanked: true

            { result: true }
          end
        end
      end
    end
  end
end
