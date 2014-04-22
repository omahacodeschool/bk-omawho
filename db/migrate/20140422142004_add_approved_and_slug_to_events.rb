class AddApprovedAndSlugToEvents < ActiveRecord::Migration
  def change
    add_column :events, :approved, :boolean, :default => false
    add_column :events, :slug, :string
  end
end
