ActiveAdmin.register User do
  permit_params :phone, :password, :password_confirmation

  index do
    selectable_column
    id_column
    column :username
    column :name
    column :phone
    column :gender
    column :job
    column :created_at
    column :updated_at
    actions
  end

  filter :name
  filter :phone

  form do |f|
    f.inputs do
      f.input :username
      f.input :phone
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end
end
