ActiveAdmin.register User do
  permit_params :email, :address, :username

  index do
    selectable_column
    id_column
    column :email
    column :username
    column :address
    column :created_at
    actions
  end

  filter :email
  filter :username
  filter :address
  filter :created_at

  form do |f|
    f.inputs do
      f.input :email
      f.input :password
      f.input :password_confirmation
      f.input :username
      f.input :address
    end
    f.actions
  end
end
