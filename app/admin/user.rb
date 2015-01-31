ActiveAdmin.register User do

  index do
    column :username
    column :current_sign_in_at
    column :last_sign_in_at
    column :sign_in_count
    column :role
    actions
  end

  filter :username

  form do |f|
    f.inputs "User Details" do
      f.input :username
      f.input :role, as: :radio,collection: {Member: "member",Admin: "admin"}
    end
    f.actions
  end  
  
  # See permitted parameters documentation:
  # https://github.com/gregbell/active_admin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
   permit_params :role, :username, :email, :password, :firstname, :lastname
  #
  # or
  #
  # permit_params do
  #  permitted = [:permitted, :attributes]
  #  permitted << :other if resource.something?
  #  permitted
  # end
  
end
