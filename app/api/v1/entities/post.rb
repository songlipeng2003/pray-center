module V1
  module Entities
    class Post < Grape::Entity
      expose :id, documentation: { type: 'Integer', desc: '编号' }
      expose :category_id, documentation: { type: 'Integer', desc: '分类编号' }
      expose :category_name, documentation: { type: 'String', desc: '分类名' } do |post|
        post.category.name
      end
      expose :region_id, documentation: { type: 'Integer', desc: '区域编号' }
      expose :region_name, documentation: { type: 'String', desc: '区域名称' } do |post|
        post.region.name
      end
      expose :user_id, documentation: { type: 'Integer', desc: '用户编号' }
      expose :user_name, documentation: { type: 'String', desc: '用户名称' } do |post|
        post.user.name
      end
      expose :is_favorited, documentation: { type: 'Boolean', desc: '是否关注' } do |post, options|
        options[:user].favorites.where(favorited_user_id: post.user_id).exists?
      end
      expose :user_avatar, documentation: { type: 'String', desc: '用户名称' } do |post|
        post.user.avatar.thumb.url
      end
      expose :title, documentation: { type: 'String', desc: '标题' }
      expose :content, documentation: { type: 'String', desc: '内容' }
      expose :pray_number, documentation: { type: 'Integer', desc: '代祷人数' }
      expose :created_at, documentation: { type: 'String', desc: '发布时间' }
      expose :is_prayed, documentation: { type: 'Boolean', desc: '是否已经代祷' } do |post, options|
        options[:user].pray_histories.where(post_id: post.id).exists?
      end
      expose :post_images, with: V1::Entities::PostImage,  documentation: { type: 'Array' }
    end
  end
end
