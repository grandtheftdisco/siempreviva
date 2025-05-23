class DenormalizeCartItems < ActiveRecord::Migration[8.0]
  def change
    add_column :cart_items, :stripe_product_id, :text, null: false
    add_column :cart_items, :name, :text, null: :false
    add_column :cart_items, :image, :text, default: 'https://www.blastone.com/wp-content/uploads/image-coming-soon-29.png', null: :false
  end
end
