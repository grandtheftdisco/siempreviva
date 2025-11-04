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

### Development Methodology
This project demonstrates a strategic approach to AI-assisted development with clear delineation of responsibilities:

**Backend Development (Human-Led)**:
- Backend architecture, service objects, and business logic developed primarily by human developer
- Rails patterns, database design, and API integrations implemented through traditional development methods
- Minimal use of AI assistance limited to occasional consultation (Claude) and code review (Copilot)

**Frontend Development (AI-Assisted)**:
- Wireframing, prototyping, and all other design planning carried out by human developer
- Frontend styling, component structure, and UI implementation developed with supervised AI assistance
- Human developer leverages frontend expertise to effectively guide and review AI-generated code
- Ensures quality control while accelerating development velocity in areas of established competency

This approach maintains architectural integrity and learning objectives while strategically leveraging AI tools where appropriate.

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

### Communication Standards
- When summarizing work or providing progress updates, use paragraph format without emojis
- Maintain professional, clear, and concise communication style
- Focus on technical details and outcomes rather than stylistic elements

### Work Log Standards
- **Time Estimates**: Can provide time estimates when planning future work
- **No Retrospective Time Tracking**: Do not report "time spent" on completed tasks in work logs, as AI cannot accurately track elapsed time
- **Focus on Accomplishments**: Work logs should document what was completed, decisions made, and context for future reference

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