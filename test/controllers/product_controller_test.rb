require "test_helper"
require "ostruct"

class ProductControllerTest < ActionDispatch::IntegrationTest
  setup do
    # Clear cache before each test
    Rails.cache.clear
  end

  # Basic functionality tests
  test "should get index" do
    StripeService::FetchProductInventory.stubs(:call).returns([])

    get products_url
    assert_response :success
  end

  test "product with no images displays placeholder" do
    product = OpenStruct.new(
      id: "prod_no_image",
      name: "Lavender Essential Oil",
      description: "Pure lavender oil",
      images: [],
      default_price: OpenStruct.new(unit_amount: 1500)
    )

    StripeService::FetchProductInventory.stubs(:call).returns([product])

    get product_path(product.id)
    assert_response :success
    assert_select "[data-product-image-placeholder]", text: "Product Image"
  end

  # Product with fewer than 5 images should not render additional image grid
  test "product with fewer than 5 images does not render additional image grid" do
    product = OpenStruct.new(
      id: "prod_few_images",
      name: "Sage Essential Oil",
      description: "Pure sage oil",
      images: ["https://example.com/image1.jpg", "https://example.com/image2.jpg"],
      default_price: OpenStruct.new(unit_amount: 1200)
    )

    StripeService::FetchProductInventory.stubs(:call).returns([product])

    get product_path(product.id)
    assert_response :success
    # Additional images grid should NOT render
    assert_select "[data-secondary-image-grid]", count: 0
  end

  # Product with 5+ images should render additional image grid
  test "product with 5 or more images renders additional image grid" do
    product = OpenStruct.new(
      id: "prod_many_images",
      name: "Lavender Essential Oil",
      description: "Pure lavender oil",
      images: [
        "https://example.com/image1.jpg",
        "https://example.com/image2.jpg",
        "https://example.com/image3.jpg",
        "https://example.com/image4.jpg",
        "https://example.com/image5.jpg"
      ],
      default_price: OpenStruct.new(unit_amount: 1500)
    )

    StripeService::FetchProductInventory.stubs(:call).returns([product])

    get product_path(product.id)
    assert_response :success
    # Additional images grid should render
    assert_select "[data-secondary-image-grid]", count: 1
  end

  test "product with missing or empty description shows fallback text" do
    [nil, ""].each do |description_value|
      product = OpenStruct.new(
        id: "prod_no_desc",
        name: "Rosemary Essential Oil",
        description: description_value,
        images: ["https://example.com/image.jpg"],
        default_price: OpenStruct.new(unit_amount: 1800)
      )

      StripeService::FetchProductInventory.stubs(:call).returns([product])

      get product_path(product.id)
      assert_response :success
      assert_select "p", text: "(product info coming soon!)"
    end
  end

  test "format_product_name handles name that does not contain 'essential oil'" do
    product = OpenStruct.new(
      id: "prod_no_eo_suffix",
      name: "Lavender",
      description: "Pure lavender",
      images: ["https://example.com/image.jpg"],
      default_price: OpenStruct.new(unit_amount: 1500)
    )

    StripeService::FetchProductInventory.stubs(:call).returns([product])

    get product_path(product.id)
    assert_response :success
    # Should still render lowercased name
    assert_select "h1.product-show-title", text: "lavender"
  end

  test "format_product_name handles name containing 'Essential Oil'" do
    product = OpenStruct.new(
      id: "prod_mixed_case",
      name: "Peppermint Essential Oil",
      description: "Pure peppermint",
      images: ["https://example.com/image.jpg"],
      default_price: OpenStruct.new(unit_amount: 1400)
    )

    StripeService::FetchProductInventory.stubs(:call).returns([product])

    get product_path(product.id)
    assert_response :success
    # Should strip "Essential Oil" and lowercase
    assert_select "h1.product-show-title", text: "peppermint"
  end

  test "if only 2 products in inventory, Section 3 only shows 1 cross-sell" do
    product1 = OpenStruct.new(
      id: "prod_1",
      name: "Lavender Essential Oil",
      description: "Pure lavender",
      images: ["https://example.com/image1.jpg"],
      default_price: OpenStruct.new(unit_amount: 1500)
    )

    product2 = OpenStruct.new(
      id: "prod_2",
      name: "Sage Essential Oil",
      description: "Pure sage",
      images: ["https://example.com/image2.jpg"],
      default_price: OpenStruct.new(unit_amount: 1200)
    )

    StripeService::FetchProductInventory.stubs(:call).returns([product1, product2])

    get product_path(product1.id)
    assert_response :success
    # Should only have 1 cross-sell (product2), since we exclude current product
    assert_select "div.cross-sell-card", count: 1
  end

  test "if only 3 products in inventory, Section 3 shows 2 cross-sells" do
    product1 = OpenStruct.new(
      id: "prod_1",
      name: "Lavender Essential Oil",
      description: "Pure lavender",
      images: ["https://example.com/image1.jpg"],
      default_price: OpenStruct.new(unit_amount: 1500)
    )

    product2 = OpenStruct.new(
      id: "prod_2",
      name: "Sage Essential Oil",
      description: "Pure sage",
      images: ["https://example.com/image2.jpg"],
      default_price: OpenStruct.new(unit_amount: 1200)
    )

    product3 = OpenStruct.new(
      id: "prod_3",
      name: "Rosemary Essential Oil",
      description: "Pure rosemary",
      images: ["https://example.com/image3.jpg"],
      default_price: OpenStruct.new(unit_amount: 1800)
    )

    StripeService::FetchProductInventory.stubs(:call).returns([product1, product2, product3])

    get product_path(product1.id)
    assert_response :success
    # Should have 2 cross-sells (excluding current product)
    assert_select "div.cross-sell-card", count: 2
  end

  test "cross-sell card with no image shows placeholder" do
    product1 = OpenStruct.new(
      id: "prod_1",
      name: "Lavender Essential Oil",
      description: "Pure lavender",
      images: ["https://example.com/image1.jpg"],
      default_price: OpenStruct.new(unit_amount: 1500)
    )

    product2 = OpenStruct.new(
      id: "prod_2",
      name: "Sage Essential Oil",
      description: "Pure sage",
      images: [], # No images
      default_price: OpenStruct.new(unit_amount: 1200)
    )

    StripeService::FetchProductInventory.stubs(:call).returns([product1, product2])

    get product_path(product1.id)
    assert_response :success
    # Cross-sell card should show placeholder text
    assert_select "span.cross-sell-placeholder-text", text: "image coming soon!"
  end

  test "product with zero price displays correctly" do
    product = OpenStruct.new(
      id: "prod_free",
      name: "Free Sample Essential Oil",
      description: "Free sample",
      images: ["https://example.com/image.jpg"],
      default_price: OpenStruct.new(unit_amount: 0)
    )

    StripeService::FetchProductInventory.stubs(:call).returns([product])

    get product_path(product.id)
    assert_response :success
    assert_select "div.product-price-display", text: "$0.00"
  end

  test "product with 4-figure price formats correctly" do
    product = OpenStruct.new(
      id: "prod_expensive",
      name: "Premium Essential Oil Collection",
      description: "Premium collection",
      images: ["https://example.com/image.jpg"],
      default_price: OpenStruct.new(unit_amount: 999900) # $9,999.00
    )

    StripeService::FetchProductInventory.stubs(:call).returns([product])

    get product_path(product.id)
    assert_response :success
    # Should format as $9,999.00 with comma separator
    assert_select "div.product-price-display", text: "$9,999.00"
  end

  # FLAG - not sure this will implement desired behavior
  # Very long product name
  test "very long product name renders without breaking layout" do
    product = OpenStruct.new(
      id: "prod_long_name",
      name: "Extremely Long Product Name That Goes On And On And Should Wrap Properly On Mobile Devices Essential Oil",
      description: "Long name test",
      images: ["https://example.com/image.jpg"],
      default_price: OpenStruct.new(unit_amount: 1500)
    )

    StripeService::FetchProductInventory.stubs(:call).returns([product])

    get product_path(product.id)
    assert_response :success
    # Should render the formatted name (without "Essential Oil")
    assert_select "h1.product-show-title"
  end

  # FLAG - not sure this will implement desired behavior.
  # Very long product description
  test "very long product description renders without breaking layout" do
    long_description = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. " * 50

    product = OpenStruct.new(
      id: "prod_long_desc",
      name: "Lavender Essential Oil",
      description: long_description,
      images: ["https://example.com/image.jpg"],
      default_price: OpenStruct.new(unit_amount: 1500)
    )

    StripeService::FetchProductInventory.stubs(:call).returns([product])

    get product_path(product.id)
    assert_response :success
    # Description should be present in prose container
    assert_select "div.prose"
  end

  test "when there are no products in inventory, product index renders without error" do
    StripeService::FetchProductInventory.stubs(:call).returns([])

    get products_path
    assert_response :success
  end

  test "product with multiple images uses first image as main" do
    product = OpenStruct.new(
      id: "prod_multi_images",
      name: "Lavender Essential Oil",
      description: "Pure lavender",
      images: [
        "https://example.com/image1.jpg",
        "https://example.com/image2.jpg",
        "https://example.com/image3.jpg"
      ],
      default_price: OpenStruct.new(unit_amount: 1500)
    )

    StripeService::FetchProductInventory.stubs(:call).returns([product])

    get product_path(product.id)
    assert_response :success
    # Should render first image
    assert_select "img[src='https://example.com/image1.jpg']"
  end
end
