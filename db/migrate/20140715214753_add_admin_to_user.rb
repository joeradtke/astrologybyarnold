class AddAdminToUser < ActiveRecord::Migration
  def up
    User.create! do |r|
      r.username='joeradtke'
      r.password='suisse11'
      r.email='joeradtke@yahoo.com'
      r.role='admin'
    end
  end
  def down
    User.find_by_username('joeradtke').try(:delete)
  end
end
