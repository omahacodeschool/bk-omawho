class AddManyColumnsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :username, :string
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :admin, :boolean
    
    add_column :users, :bio, :text
    add_column :users, :website, :string
    add_column :users, :company, :string
    add_column :users, :company_site, :string
    
    add_column :users, :facebook, :string
    add_column :users, :twitter, :string
    add_column :users, :pinterest, :string
    add_column :users, :linkedin, :string
    add_column :users, :github, :string
    add_column :users, :googleplus, :string
    add_column :users, :dribbble, :string
    add_column :users, :instagram, :string
    add_column :users, :tumblr, :string
     
  end
end
