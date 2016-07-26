module V1
  class Posts < Grape::API
    before do
      error!("401 Unauthorized", 401) unless authenticated
    end

    resource :posts do
      desc "帖子",
        is_array: true,
        http_codes: [
         [200, '成功', V1::Entities::Post]
        ]
      params do
        optional 'X-Access-Token', type: String, desc: 'Token', documentation: { in: :header }
      end
      get do
        present Post.order('id DESC').all, with: V1::Entities::Post
      end

      desc "帖子详情",
        http_codes: [
          [200, 'Ok', V1::Entities::Post]
        ]
      params do
        optional 'X-Access-Token', type: String, desc: 'Token', documentation: { in: :header }
        requires :id, type: Integer, desc: "编号"
      end
      route_param :id do
        get do
          present Post.find(params[:id]), with: V1::Entities::Post
        end
      end

      desc "添加帖子",
        http_codes: [
          [201, '成功', V1::Entities::Post],
          [422, 'Unprocesable entity', V1::Entities::Error]
        ]
      params do
        optional 'X-Access-Token', type: String, desc: 'Token', documentation: { in: :header }
        requires :category_id, type: Integer, desc: "分类"
        requires :title, type: String, desc: "标题"
        requires :content, type: String, desc: "内容"
      end
      post do
        safe_params = clean_params(params).permit(:title, :content, :category_id)
        post = current_user.posts.new(safe_params)
        # post.application = current_application
        if post.save
          present post, with: V1::Entities::Post
        else
          error!({ error: post.errors.full_messages.first }, 422)
        end
      end

      desc "编辑帖子",
        http_codes: [
          [201, '成功', V1::Entities::Post],
          [422, 'Unprocesable entity', V1::Entities::Error]
        ]
      params do
        optional 'X-Access-Token', type: String, desc: 'Token', documentation: { in: :header }
        requires :id, type: Integer, desc: "编号"
        requires :title, type: String, desc: "标题"
        requires :content, type: String, desc: "内容"
      end
      route_param :id do
        put do
          post = current_user.posts.find(params[:id])
          safe_params = clean_params(params).permit(:title, :content)
          post.update(safe_params)
          present post, with: V1::Entities::Post
        end
      end

      desc "删除地址",
        http_codes: [
          [204, '成功']
        ]
      params do
        optional 'X-Access-Token', type: String, desc: 'Token', documentation: { in: :header }
        requires :id, type: Integer, desc: "编号"
      end
      route_param :id do
        delete do
          post = current_user.posts.find(params[:id])
          post.destroy
          status 204
          # { code: 0 }
        end
      end
    end
  end
end
