# In migrating dev to Linux, I needed to run this migration after finding that
# my re-running of all other migrations didn't update cart_items appropriately

# this one will ONLY add the needed columns. future migrations will 
#   1. remove the product_id column that's been made obsolete
#   2. add the index of cart_id < > stripe_product_id
# fingers crossed that this works.
class UpdateColumnsOnCartItemsToMatchNativeWindowsSchema < ActiveRecord::Migration[8.0]
  def change
    add_column :cart_items, :stripe_product_id, :text, null: false
    add_column :cart_items, :quantity, :integer, default: 1, null: false
    add_column :cart_items, :name, :text
    add_column :cart_items, :image, :text, default: "https://www.blastone.com/wp-content/uploads/image-coming-soon-29.png" 
  end
end
