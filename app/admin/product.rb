ActiveAdmin.register Product do
  form :partial=>"form"
  index do
    column:category
    column:name
    column:short
    column:price do |product|
      number_to_currency product.price
    end
    actions
  end
  # See permitted parameters documentation:
  # https://github.com/gregbell/active_admin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  permit_params :name, :short, :photo,:description, :price ,:category_id
  #
  # or
  #
  # permit_params do
  #  permitted = [:permitted, :attributes]
  #  permitted << :other if resource.something?
  #  permitted
  # end
  
end
