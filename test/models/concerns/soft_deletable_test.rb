require "test_helper"

class SoftDeletableTest < ActiveSupport::TestCase
  setup do
    @cart = Cart.create!(session_id: "restore_test_session", status: "open")
    @item_one = CartItem.create!(cart: @cart, stripe_product_id: "prod_1", price: 500, quantity: 2)
    @item_two = CartItem.create!(cart: @cart, stripe_product_id: "prod_2", price: 1000, quantity: 1)
  end

  test "restore clears deleted_at and status on the record" do
    @cart.soft_delete_records

    assert_not_nil @cart.reload.deleted_at
    assert_equal "soft_deleted", @cart.status

    @cart.restore

    assert_nil @cart.reload.deleted_at
    assert_nil @cart.status
  end

  test "restore clears deleted_at on soft-deleted associated records" do
    @cart.soft_delete_records

    deleted_items = CartItem.only_deleted.where(cart_id: @cart.id)
    assert_equal 2, deleted_items.count

    @cart.restore

    restored_items = CartItem.where(cart_id: @cart.id)
    assert_equal 2, restored_items.count
    assert restored_items.all? { |item| item.deleted_at.nil? }
  end

  test "restore makes cart visible to default scope again" do
    @cart.soft_delete_records

    assert_nil Cart.find_by(id: @cart.id)

    @cart.restore

    assert_equal @cart, Cart.find(@cart.id)
  end

  test "restore makes cart items visible through association again" do
    @cart.soft_delete_records

    assert_empty @cart.cart_items.reload

    @cart.restore
    @cart.reload

    assert_equal 2, @cart.cart_items.count
  end

  test "restore preserves item data" do
    @cart.soft_delete_records
    @cart.restore
    @cart.reload

    item_one = @cart.cart_items.find_by(stripe_product_id: "prod_1")
    item_two = @cart.cart_items.find_by(stripe_product_id: "prod_2")

    assert_equal 500, item_one.price
    assert_equal 2, item_one.quantity
    assert_equal 1000, item_two.price
    assert_equal 1, item_two.quantity
  end

  test "restore is idempotent on an already-active record" do
    @cart.restore

    assert_nil @cart.reload.deleted_at
    assert_nil @cart.status
    assert_equal 2, @cart.cart_items.count
  end
end
