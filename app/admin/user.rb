ActiveAdmin.register User do
  permit_params :username, :phone, :password, :password_confirmation

  index do
    selectable_column
    id_column
    column :username
    column :name
    column :phone
    column :gender
    column :invitation_code
    column :status do |user|
      user.status_text
    end
    column :created_at
    actions
  end

  filter :name
  filter :phone
  filter :status, as: :select, collection: User::STATUSES.invert

  form do |f|
    f.inputs do
      f.input :username
      f.input :phone
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end

  batch_action :pass, confirm: '你确认要通过这些用户吗？' do |ids|
    number = 0
    ids.map do |id|
      user = User.find(id)
      if user.status == User::STATUS_PENDING
        user.status = User::STATUS_CHECKED
        user.save() && ++number
      end
    end

    redirect_to :back, notice: "通过用户成功"
  end

  batch_action :refuse, confirm: '你确认要拒绝这些用户吗？' do |ids|
    number = 0
    ids.map do |id|
      user = User.find(id)
      if user.status == User::STATUS_PENDING
        user.status = User::STATUS_REFUSED
        user.save && ++number
      end
    end

    redirect_to :back, notice: "拒绝用户成功"
  end
end
