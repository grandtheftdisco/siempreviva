# 🪻 Siempreviva - Full-Stack Ecommerce Platform

## 🎯 Summary
**Production-ready ecommerce application built with Ruby on Rails for a real client**

✨ **Key Accomplishments:**
- Built complete Stripe payment integration with webhooks, order management, and refund handling
- Developed admin dashboard with authentication, order fulfillment workflow, and inventory management  
- Implemented responsive cart system with real-time updates and mobile-optimized UI
- Created comprehensive service object architecture with TDD approach
- Integrated Redis caching and background job processing for production scalability

🛠️ **Tech Stack:** Ruby on Rails, PostgreSQL, Stripe API, Tailwind CSS, Redis, Background Jobs  
⏱️ **Timeline:** March 2025 - Present (8+ months of active development)  
🏢 **Client:** Real small business (Siempreviva) - not a tutorial project  

## 📈 Latest Progress Update (October 2025)

I've been heads-down building and just pushed some major features! 🚀

**Major Backend Wins**: 
- Refined and polished the admin dashboard UI for better order fulfillment workflow
- Added pagination and filtering to admin order views for better usability

**Frontend Progress**: 
- Completely overhauled the cart system! Now there's a slick dropdown preview when you hover over the cart icon, plus a full "My Bag" view
- Implemented responsive header with mobile-friendly navigation - search and menu now collapse properly on mobile
- Organized my CSS properly by breaking stylesheets into view-specific files using SASS components
- Added Flowbite components for better UI consistency

**DevEx Improvements**:
- Added RuboCop Airbnb for code quality
- Set up proper font loading and responsive design patterns

**All in All**: This took WAY longer than expected, but I'm learning so much about real-world Rails architecture. The admin dashboard alone taught me tons about authentication, authorization, and API integration patterns.

______________________________________

# 🏗️ PROJECT DETAILS

## 🎯 Project Goals & Approach
**Challenge Level**: This is my second webdev project - a significant step up from [Henventory](https://www.github.com/grandtheftdisco/henventory) to tackle real-world ecommerce complexity.

**Real Client Work**: Built for actual business owners (not a tutorial project), giving me valuable experience working with stakeholder requirements and real-world constraints.

## 👥 Team & Mentorship  
**Technical Mentor**: Bookis - indispensable guidance throughout the process  
**Client Collaboration**: Direct feedback from Siempreviva business owners during design and development phases  
**AI Usage Transparency**: 🤖 Strategic AI assistance for frontend work where I can effectively supervise, while building all backend architecture and business logic myself to strengthen those skills.

## 🛠️ Tech Stack
- **Backend**: Ruby on Rails, PostgreSQL  
- **Payments**: Stripe API, Stripe.js with full webhook integration  
- **Frontend**: Tailwind CSS, SASS, Flowbite components, responsive design  
- **Infrastructure**: Redis caching, background jobs, Linux development environment  
- **Code Quality**: RuboCop-enforced Airbnb style guide, comprehensive testing with TDD  
- **Deployment**: Render (projected)

## 📬 Connect
- 💼 **Portfolio Discussion**: [Drop me a line!](mailto:grandtheftdisco@gmail.com)  
- 🚀 **Status**: Actively building - watch this repo for updates!

______________________________________

# 📚 DEVELOPMENT DIARY ARCHIVE 
*Complete development journey from March 2025 - for those interested in the full story*

## 📆 **6/13/25 - 7/11/25** *(The Summer Sprint I Forgot to Document! 👩🏻‍💻 Heads Down & Locked In)* 
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

## 📆 **5/23/25**
- Completed my `CartService` objects: `AddToCart` and `CartCalculator` are now functional and merged into `main` after code review!
- Also switched from using my own `products` table to using Stripe Products that were generated in the web dashboard; this will make it easy for the product owners to add, remove, and disable/enable products with ease.
- I wrote my first wrapper (inherited from `SimpleDelegator` with a `price` method to simply retrieval of a Stripe Product's price after retrieving the Product object via an API call
- There was a lot I did this week: check out my [service object PR](https://github.com/grandtheftdisco/siempreviva/pull/3) and my [Stripe Product switch PR](https://github.com/grandtheftdisco/siempreviva/pull/4) to see everything I wrote!

## 📆 **5/16/25**
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

## 📆 **5/9/25**
- No code review this week: this feature is taking longer than I thought!
- I'm still working on implementing my first service object, which will itemize a cart's contents, as well as any discounts/shipping/taxes, and then calculate a total
- I've been writing this class with TDD, which has been a great experience so far.
- It's been a challenge to estimate how much time it will take to build features.
  - This one is certainly taking longer than I anticipated, but I'm learning a lot: and seeing just how much work goes into the back-end of an app.
- I've been strengthening my command of Ruby, too.
  - `dig` and `sum` came to the rescue today!
  - Nested collections are tricky, but I'm committed to understanding my way around them.

## 📆 **5/2/25**
- I've got a bare-bones version of my checkout flow wired up. It's not pretty, but it works!
- What's next?
  - I'm preparing to refactor some of my controller logic for cart updates into a service object.
  - I've also got plans to implement a 2nd service object that will soft-delete a `Cart` & its associated `Checkout` object when a Stripe `PaymentIntent` is marked as `succeeded`
