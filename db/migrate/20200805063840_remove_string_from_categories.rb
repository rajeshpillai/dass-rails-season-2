class RemoveStringFromCategories < ActiveRecord::Migration[6.0]
  def change
    remove_column :categories, :string, :string
  end
end
