class AddCategoryToPost < ActiveRecord::Migration
  def change
    add_column :posts, :category_id, :string, :default => false
  end
end
