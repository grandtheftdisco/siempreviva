# 🪻 Siempreviva - Full-Stack Ecommerce Platform

## 🎯 Summary
**Production-ready ecommerce application built with Ruby on Rails for a real client**

✨ **Key Accomplishments:**
- Integrated Cloudinary API for optimized & responsive asset management
- Built complete Stripe payment integration with webhooks, order management, and refund handling
- Developed admin dashboard with authentication, order fulfillment workflow, and inventory management  
- Implemented responsive cart system with real-time updates and mobile-optimized UI
- Created comprehensive service object architecture with TDD approach
- Integrated Redis caching and background job processing for production scalability

🛠️ **Stack:** Ruby on Rails, PostgreSQL, Stripe API, Tailwind CSS, Redis 
⏱️ **Timeline:** March 2025 - Present (10+ months of active development)  
🏢 **Client:** Real small business (Siempreviva): not a tutorial project  

## 📈 Latest Progress Update (January 30, 2026)
**A Heads-down Winter**
- I've spent the past few months preparing to present the MVP of the site to my clients!
- My technical mentor has helped me get my devops ducks in a row as I prepare for 2 stages of deployment:
  - what I'm calling a 'toy deploy', to give my clients a private preview of their site to play around with. This will give them more time & bandwidth to provide feedback, instead of compressing the feedback cycle into a single meeting.
  - the final production site
- I spent a lot of time on the front end, building all static & marketing pages to spec, including a photo gallery with a lightbox feature.
- I had a great experience integrating Cloudinary into the repo. Their dev-friendly documentation made it a breeze to rely on their CDN for performant asset management.
- Last but not least, I finally finished the CSS refactor project! Here are the relevant PRs grouped together:
  - [PR #24 - Phase 1](https://github.com/grandtheftdisco/siempreviva/pull/24)
  - [PR #25 - Project Docs](https://github.com/grandtheftdisco/siempreviva/pull/24)
  - [PR #27 - CSS for Product Pages](https://github.com/grandtheftdisco/siempreviva/pull/27)
  - [PR #28 - CSS for Layout Elements](https://github.com/grandtheftdisco/siempreviva/pull/28)
  - [PR #29 - Updating Plan for Phase 4](https://github.com/grandtheftdisco/siempreviva/pull/29)
  - [PR #31 - View Migrations & Legacy Code Deprecation](https://github.com/grandtheftdisco/siempreviva/pull/31)
  - [PR #32 - Project Plan Update](https://github.com/grandtheftdisco/siempreviva/pull/32)
  - [PR #35 - CSS for Cart Flow](https://github.com/grandtheftdisco/siempreviva/pull/35)
  - [PR #36 - CSS for Checkout Flow](https://github.com/grandtheftdisco/siempreviva/pull/36)
  - [PR #37 - CSS for Email & Search Flow](https://github.com/grandtheftdisco/siempreviva/pull/37)
  - [PR #38 - Project Plan Update](https://github.com/grandtheftdisco/siempreviva/pull/38)
  - [PR #39 - Post-Merge Fixes (incl UI bugs, component definition, color conflicts, & legacy code deprecation)](https://github.com/grandtheftdisco/siempreviva/pull/39)
  - [PR #40 - Project Plan Update](https://github.com/grandtheftdisco/siempreviva/pull/40)
  - [PR #42 - Specificity Adjustments & Semantic Grouping](https://github.com/grandtheftdisco/siempreviva/pull/42)

______________________________________

# 🏗️ PROJECT DETAILS

## 🎯 Project Goals & Approach
**Challenge Level**: This is my second webdev project: a significant step up from [Henventory](https://www.github.com/grandtheftdisco/henventory) to tackle real-world ecommerce complexity.

**Real Client Work**: Built for actual business owners (not a tutorial project), giving me valuable experience working with stakeholder requirements and real-world constraints.

## 👥 Team & Mentorship  
**Technical Mentor**: Bookis - indispensable guidance throughout the process  
**Client Collaboration**: Direct feedback from Siempreviva business owners during design and development phases  
**AI Usage Transparency**: 🤖 Strategic AI assistance for frontend work where I can effectively supervise, while building all backend architecture and business logic myself to strengthen those skills.

## 🛠️ Tech Stack
- **Backend**: Ruby on Rails, PostgreSQL  
- **Payments**: Stripe API, Stripe.js with full webhook integration  
- **Frontend**: Tailwind CSS, Flowbite components  
- **Infrastructure**: Redis caching, service layer, background jobs, Linux development environment  
- **Code Quality**: RuboCop-enforced Airbnb style guide, comprehensive testing with TDD  
- **Deployment**: Heroku (projected)

## 📬 Connect
- 💼 **Portfolio Discussion**: [Drop me a line!](mailto:grandtheftdisco@gmail.com)  
- 🚀 **Status**: Actively building - watch this repo for updates!

______________________________________

# 📚 DEVELOPMENT DIARY ARCHIVE
*Complete development journey from March 2025 - for those interested in the full story*

## 📆 **November 2025** *(Cart & Checkout Polish, CSS Refactor)*
**Cart & Checkout System Overhaul** ([PR #21](https://github.com/grandtheftdisco/siempreviva/pull/21), [#22](https://github.com/grandtheftdisco/siempreviva/pull/22), [#23](https://github.com/grandtheftdisco/siempreviva/pull/23)):
- Built comprehensive checkout flow with post-payment success states and robust error handling
- Styled cart view & cart preview dropdown with full responsive design across all screen sizes
- Implemented race condition mitigation for payment processing (added `WebhookSynchronizationService::EnsurePaymentProcessed`)
- Enhanced webhook processing with idempotency checks and atomic transactions
- Reordered cart page elements to reduce purchase friction (checkout button appears before itemized list)
- Fixed cart item functionality (proper PATCH requests, consistent delete buttons, timestamp ordering)
- Added empty cart state with "shop now" prompt

**The Big CSS Refactor Plot Twist**:
Here's where things got interesting. I'd been using AI to help with frontend work, but I hadn't been supervising closely enough early on. The result? A mess of SCSS and vanilla CSS that didn't work well with Tailwind, inconsistent color usage, and no clear component system. Lesson learned: even when using AI for areas where you're strong, you still need to stay hands-on!

**Phase 1: Foundation Reset** ([PR #24](https://github.com/grandtheftdisco/siempreviva/pull/24)):
- Converted SCSS → pure CSS with Tailwind v4 `@theme` directive
- Built custom `sv-` color palette system (purple, green, gray, pink) using Tailwind's scale
- Created modern component button classes (`.btn-primary`, `.btn-secondary`, `.btn-green`, etc.)
- Converted all existing classes to use `@apply` with the new color system
- Maintained full backward compatibility (zero breaking changes to cart/checkout)
- Reorganized stylesheets into focused modules (cart.css, forms.css, layout.css, search.css, etc.)

**Ongoing: Session-by-Session Refactoring**:
Now I'm methodically working through each area of the site to convert everything to the new system:
- **Product Views** ([PR #26](https://github.com/grandtheftdisco/siempreviva/pull/26), [#27](https://github.com/grandtheftdisco/siempreviva/pull/27)): Added cross-selling, quantity selectors, responsive image grids, and converted all styling to `@apply` with semantic grouping
- **Layout Components** ([PR #28](https://github.com/grandtheftdisco/siempreviva/pull/28)): Split monolithic layout.css (403 lines) into focused modules (header, navigation, footer), converted to `@apply`, fixed mobile cart dropdown bug
- **Forms Migration** ([PR #31](https://github.com/grandtheftdisco/siempreviva/pull/31)): Migrated all forms to explicit component classes (`.form-container`, `.label-text`, `.input-text`), removed element selectors, applied semantic grouping pattern

**Documentation & Process** ([PR #25](https://github.com/grandtheftdisco/siempreviva/pull/25)):
- Restructured original 670+ line CSS refactor plan into organized `project_plan/` directory with session-based docs
- Created technical reference docs for color systems, components, and design decisions
- Established clear workflow for remaining refactoring sessions

**What I'm Learning**:
This CSS refactor has been humbling but incredibly valuable. I'm learning about proper component architecture, the importance of maintainable code organization, and how to effectively supervise AI assistance. The session-by-session approach is keeping the work manageable while steadily improving code quality. Plus, I'm getting much better at debugging CSS issues!

## 📆 **10/1/25 - 10/31/25** *(Admin Dashboard Polish & Initial Cart Work)*
- **Admin Dashboard Refinement**:
  - Polished the admin dashboard UI for better order fulfillment workflow
  - Added pagination and filtering to admin order views for better usability
- **Cart System Foundation**:
  - Began overhaul of cart system with dropdown preview and full "My Bag" view
  - Started implementing responsive header with mobile-friendly navigation
  - Initial work on organizing CSS into view-specific files using SASS components
  - Added Flowbite components for better UI consistency
- **DevEx Improvements**:
  - Added RuboCop Airbnb for code quality
  - Set up proper font loading and responsive design patterns
- **Reflection**: This phase took much longer than expected, but taught me tons about real-world Rails architecture. The admin dashboard work alone was a masterclass in authentication, authorization, and API integration patterns.

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
