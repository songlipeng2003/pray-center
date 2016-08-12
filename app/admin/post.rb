ActiveAdmin.register Post do
  permit_params :user_id, :category_id, :region_id, :title, :content

  index do
    selectable_column
    id_column
    column :user
    column :category
    column :region
    column :title
    column :created_at
    column :updated_at
    actions
  end

  filter :title

end
