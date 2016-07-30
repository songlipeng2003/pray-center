ActiveAdmin.register Post do
  permit_params :phone, :password, :password_confirmation

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
