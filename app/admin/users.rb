# Export to CSV with the referrer_id
ActiveAdmin.register User do
  csv do
    column :id
    column :email
    column :referral_code
    column :referrer_id
    column :created_at
    column :updated_at
  end

  actions :index, :show

  index do
    column :id
    column :email
    column :referral_code
    column :num_referred
    column :created_at
    column :updated_at
  end

  show do
    attributes_table do
      row :id
      row :email
      row :referral_code
      row :referrer_id
      row :created_at
      row :updated_at
      row :num_referred do |user|
        user.num_referred
      end
    end
  end
end
