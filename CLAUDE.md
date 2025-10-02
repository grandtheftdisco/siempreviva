# CLAUDE.md - Development Context for Siempreviva 🪻

## Project Overview
**Siempreviva** is an e-commerce Rails application for a small business, currently under active development. This project builds on lessons learned from previous work and focuses on scalable architecture patterns.

### Key Technologies
- **Framework**: Ruby on Rails 8.0.2
- **Database**: PostgreSQL  
- **Frontend**: Turbo/Stimulus (Hotwire)
- **Payments**: Stripe API
- **Styling**: Tailwind CSS
- **Authentication**: Rails 8 `Authentication` module
- **Background Jobs**: Solid Queue
- **Caching**: Redis

## Architecture & Design Patterns

### Service Object Architecture
The application uses a service layer to encapsulate business logic:
- **Base Class**: `ApplicationService` 
- **Service Modules**: 
  - `AdminService` - handles administrative functions for order fulfilment
  - `AlgoliaService` - updates search index when inventory is updated
  - `CartService` - handles line items, cart calculations, inventory & price validation, etc.
  - `PaymentHandlingService` - handles business logic that follows a successful transaction
  - `StripeService` - caches inventory updates

### Domain Models
- **Cart**: Session-based identification with soft deletion
- **CartItem**: Line items within shopping carts
- **Checkout**: Payment processing workflow
- **Order**: Completed purchase records
- **Products**: Managed via Stripe Products API

### Application Structure
- **Marketing Controllers**: Static pages (home, contact, gallery)
- **E-commerce Controllers**: Product catalog, cart management, checkout flow
- **Admin Controllers**: Administrative functionality
- **Webhook Handlers**: External service integration

## Development Approach

### Testing Strategy
- Test-Driven Development (TDD)
- Comprehensive service object testing
- Standard Rails testing framework

### Code Organization
- Service objects follow single responsibility principle
- Controllers remain thin, delegating to service layer
- Models focus on data relationships and validations
- Concerns used for shared behavior (e.g., `SoftDeletable`)

### Integration Patterns
- Stripe Products API for product management
- Webhook-based payment confirmation
- Session-based cart persistence
- Soft deletion for data integrity

## Development Standards

### Code Conventions
- Follow Rails best practices and conventions
- Service objects use `.call` class method pattern
- Meaningful naming for classes, methods, and variables
- Consistent error handling and validation

### Feature Development Process
- Feature branches for new development
- Code review before merging to main
- Incremental development with regular integration

## Business Context
E-commerce platform for a small business in the agricultural/botanical space, handling product catalogs, shopping cart functionality, and secure payment processing.

## Current Development Focus
- Frontend styling to meet spec (ie, Figma wireframes)
- Service layer refinement  
- Administrative feature development
- Performance optimization

---
*This documentation serves as a reference for understanding the project's architecture, patterns, and development approach.*