ActiveAdmin.register Notification do

  actions :index, :show

  index do
    selectable_column
    id_column
    column :user
    column :target
    column :content
    column :created_at
    column :updated_at
    actions
  end

end
