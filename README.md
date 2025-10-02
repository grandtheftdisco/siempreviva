# 🪻 Welcome to Siempreviva!
- This is my second webdev project: an ecommerce site for a small business.

## ⚒️ UNDER CONSTRUCTION 
- I'm building this project as you read this, so watch the repo or check back often to see my progress!

- 📆 **10/2/25** 
  - Okay, I've been TERRIBLE about updates, but SO much has happened! 🚀
  - **Major Backend Wins**: 
    - Refined and polished the admin dashboard UI for better order fulfillment workflow.
    - Added pagination and filtering to admin order views for better usability.
  - **Frontend Progress**: 
    - Completely overhauled the cart system! Now there's a slick dropdown preview when you hover over the cart icon, plus a full "My Bag" view.
    - Implemented responsive header with mobile-friendly navigation - search and menu now collapse properly on mobile.
    - Organized my CSS properly by breaking stylesheets into view-specific files using SASS components.
    - Added Flowbite components for better UI consistency.
  - **DevEx Improvements**:
    - Added the `rubocop-airbnb` gem and adopted its style guide (see `.rubocop.yml` for configuration).
    - Set up proper font loading and responsive design patterns.
  - **The Real Talk**: This took WAY longer than expected, but I'm learning so much about real-world Rails architecture. The admin dashboard alone taught me tons about authentication, authorization, and API integration patterns.

- 📆 **6/13/25 - 7/11/25** *(The Summer Sprint I Forgot to Document! 👩🏻‍💻 Heads Down & Locked In)* 
  - **Webhook & Payment Infrastructure**: 
    - Built a complete Stripe webhook system from scratch! 🎯 This was HARD but so rewarding.
    - Implemented proper handling of checkout sessions, payment intents, and refund events.
    - Added Redis caching for duplicate event prevention (Stripe best practices).
    - Created comprehensive logging and admin email notifications for unexpected events.
  - **Order Management System**:
    - Created the Order model and OrderMailer for customer confirmations.
    - Built tracking number functionality that syncs between Postgres and Stripe metadata.
    - Added order status updates (shipped, refunded, etc.) with proper timestamping.
  - **Cart Validation & Error Handling**:
    - Implemented cart validation services (`CheckItemInventory`, `CheckItemPrices`) that run before checkout.
    - Added proper error handling throughout controllers - no more mysterious crashes! 
    - Built cart cleanup system that hard-deletes carts after successful payments.
  - **Authentication Deep Dive**:
    - Built admin-only namespaced controllers and views.
    - Implemented proper session management and authentication flows.
  - **Background Jobs**:
    - Created async payment checking job for payment methods that take time to process.
    - Added retry logic with admin notifications for failed payments.
  - **Development Environment**:
    - Finally switched to Linux! (No more Windows development pain 🎉)
    - Set up proper webhook testing with ngrok.
    - Dealt with SO many Tailwind issues (even uninstalled and reinstalled from scratch once).
  - **Lessons Learned**: Webhooks are no joke. Error handling is everything. And proper service object architecture makes debugging 1000x easier when things go wrong (which they will!).

- 📆 **5/23/25**
  - Completed my `CartService` objects: `AddToCart` and `CartCalculator` are now functional and merged into `main` after code review!
  - Also switched from using my own `products` table to using Stripe Products that were generated in the web dashboard; this will make it easy for the product owners to add, remove, and disable/enable products with ease.
  - I wrote my first wrapper (inherited from `SimpleDelegator` with a `price` method to simply retrieval of a Stripe Product's price after retrieving the Product object via an API call
  - There was a lot I did this week: check out my [service object PR](https://github.com/grandtheftdisco/siempreviva/pull/3) and my [Stripe Product switch PR](https://github.com/grandtheftdisco/siempreviva/pull/4) to see everything I wrote!

- 📆 **5/16/25**
  - No code review this week either: but I'm almost ready to submit a PR!
    - I've pushed the code I've written so far - it's in the [amanda/cart-calculator](https://github.com/grandtheftdisco/siempreviva/tree/amanda/cart-calculator) branch.
    - Feel free to check it out! I plan to push a few more commits to finalize my classes next week, and then submit for review.
  - I have my first service object functioning at a basic level! 🎉
    - I've written a handful of tests (TDD) and all are passing. Time to write more, right?
  - Bookis and I isolated some code that constituted its own service object, so I also began writing that class, too.
  - Now, I've got:
    - `AddToCart` ([code](https://github.com/grandtheftdisco/siempreviva/blob/amanda/cart-calculator/app/services/cart_service/add_to_cart.rb)) - a service object that adds a product to a cart, and 
    - `CalculateCart` ([code](https://github.com/grandtheftdisco/siempreviva/blob/amanda/cart-calculator/app/services/cart_service/calculate_cart.rb)) - a service object that calculates a cart's total. 
  - I also made the decision to write the frontend of this app in React ⚛️
    - I may write a Hotwire version, as well, to learn both libraries. Going with React for now to be as marketable as possible!

- 📆 **5/9/25**
  - No code review this week: this feature is taking longer than I thought!
  - I'm still working on implementing my first service object, which will itemize a cart's contents, as well as any discounts/shipping/taxes, and then calculate a total
  - I've been writing this class with TDD, which has been a great experience so far.
  - It's been a challenge to estimate how much time it will take to build features.
    - This one is certainly taking longer than I anticipated, but I'm learning a lot: and seeing just how much work goes into the back-end of an app.
  - I've been strengthening my command of Ruby, too.
    - `dig` and `sum` came to the rescue today!
    - Nested collections are tricky, but I'm committed to understanding my way around them.

- 📆 **5/2/25**
  - I've got a bare-bones version of my checkout flow wired up. It's not pretty, but it works!
  - What's next?
    - I'm preparing to refactor some of my controller logic for cart updates into a service object.
    - I've also got plans to implement a 2nd service object that will soft-delete a `Cart` & its associated `Checkout` object when a Stripe `PaymentIntent` is marked as `succeeded`

______________________________________
______________________________________
______________________________________

# PROCESS

## Goals
- My main goal with this project is to challenge myself beyond my comfort zone.
- I want to take what I've learned from [Henventory](https://www.github.com/grandtheftdisco/henventory) and use it as a foundation to build something more complex.

## Team
- I could **never** call this a solo project and be able to sleep at night.
- My technical mentor Bookis, as always, has been indispensable throughout the process.
- I'm also extremely grateful for the feedback that the Siempreviva owners gave me during the design process.
  - It's not often you get to build something for a real customer this early in your webdev journey!
  - Thank you to these wonderful women for giving me a chance.

## Development Approach 🤖
- I'm being super transparent about my AI usage here because I want to be clear about what's human effort vs. AI assistance.
- **Backend stuff**: That's all me! 💪 I'm building the Rails architecture, service objects, and business logic myself to really learn the patterns. I occasionally ask Claude questions, but I'm writing the code.
- **Frontend work**: Here's where I lean more on AI assistance. Since I'm more comfortable with frontend concepts (thank you, MySpace days), I can effectively supervise and review AI-generated styling and component code. It speeds me up without compromising quality.
- Basically, I'm using AI strategically where I already have the expertise to guide it properly, while doing the heavy architectural lifting myself where I want to build those skills from scratch.

## Stack
- Ruby on Rails
- Postgres
- Stripe API
- Stripe.js
- _React_ (projected)
- Tailwind
- _Render_ (projected deployment platform)

## Timeframe
- March 2025 - now
- Admittedly, it's hard to forecast how long this project will take, since it's my first one that's this complex.

## 🧑‍💻 Got some advice for me?
- I'm all ears!
- [Drop me a line.](mailto:grandtheftdisco@gmail.com)

______________________________________
______________________________________
______________________________________

## Outcomes
- _coming soon!_

## What I Learned
- _coming soon!_
