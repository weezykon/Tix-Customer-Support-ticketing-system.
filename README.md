# TixApp - Customer Support Ticketing System (API Only)

## Project Description

TixApp is a robust, API-only backend for a customer support ticketing system, built with Ruby on Rails and GraphQL. It allows customers to submit support requests and interact with support agents, while providing agents with tools to manage and respond to tickets, including file attachments, ticket assignment, and data export functionalities.

## Key Features

*   **Complete Authentication System:** Secure JWT (JSON Web Token) based authentication for both customers and support agents.
*   **Customer Functionality:**
    *   Create new support tickets.
    *   View the status of their submitted tickets.
    *   Add comments to tickets (with business logic: customers can only comment after an agent has made the first comment).
*   **Support Agent Functionality:**
    *   View all tickets in the system.
    *   Respond to tickets by adding comments.
    *   Assign tickets to specific agents.
    *   Update ticket statuses.
    *   Export closed tickets data to CSV format.
    *   Access an endpoint for daily open ticket reminders.
*   **File Upload System:** Attach images and PDF files to tickets using Active Storage.
*   **GraphQL API:** All interactions are exposed through a single, powerful GraphQL endpoint.
*   **Proper Access Controls & Business Logic:** Granular authorization rules ensure users can only perform actions relevant to their roles and ticket ownership.

## Prerequisites

Before you begin, ensure you have the following installed on your system:

*   **Ruby:** Version 3.2.2 (or compatible, as specified in `Gemfile`)
*   **Rails:** Version 7.0.8.3 (or compatible, as specified in `Gemfile`)
*   **PostgreSQL:** A robust relational database system.
*   **Node.js:** Required for some Active Storage dependencies.
*   **Yarn:** A package manager for JavaScript (often installed with Node.js).

## Getting Started

Follow these steps to set up and run the TixApp backend on your local machine.

### 1. Clone the Repository

```bash
git clone https://github.com/weezykon/Tix-Customer-Support-ticketing-system.git
cd Tix-Customer-Support-ticketing-system
```

### 2. Install Dependencies

Install the required Ruby gems and JavaScript packages:

```bash
bundle install
yarn install
```

### 3. Environment Variables Setup

Create a `.env` file in the root of the project directory (`tix-app/`). This file will store sensitive information and configuration specific to your environment.

```bash
touch .env
```

Open the `.env` file and add the following variables. Replace the placeholder values with your actual secrets and configurations.

```dotenv
# --- Required for JWT Authentication ---
# Secret key for JWT authentication. Generate a strong, random key.
# You can generate a suitable key using `rails secret` in your terminal.
DEVISE_JWT_SECRET_KEY=your_super_secret_jwt_key_here

# --- Common Rails Application Environment Variables ---

# Rails Secret Key Base (for session management, cookie signing, etc.)
# Generate with `rails secret`
SECRET_KEY_BASE=your_rails_secret_key_base_here

# Database Configuration (PostgreSQL example)
# DATABASE_URL=postgresql://user:password@host:port/database_name
PGUSER=your_db_user
PGPASSWORD=your_db_password
PGHOST=localhost
PGPORT=5432
PGDATABASE=tix_app_development

# Mailer Configuration (for sending emails, e.g., password resets)
MAILER_ADDRESS=smtp.example.com
MAILER_PORT=587
MAILER_USERNAME=your_mailer_username
MAILER_PASSWORD=your_mailer_password
MAILER_DOMAIN=example.com

# Active Storage (Amazon S3 example - uncomment and configure if using S3)
# AWS_ACCESS_KEY_ID=your_aws_access_key_id
# AWS_SECRET_ACCESS_KEY=your_aws_secret_access_key
# AWS_REGION=your_aws_region
# AWS_BUCKET=your_aws_bucket_name

# Application Host (for generating full URLs in emails or API responses)
HOST=localhost:3000
```

**Important:** For `DEVISE_JWT_SECRET_KEY` and `SECRET_KEY_BASE`, generate strong, unique keys using `rails secret` in your terminal and paste them into the `.env` file.

### 4. Database Setup

Create and migrate your PostgreSQL database:

```bash
rails db:create
rails db:migrate
```

### 5. Running the Application

Start the Rails server:

```bash
rails s
```

The application will be running at `http://localhost:3000`.

## API Endpoints (GraphQL)

All interactions with the TixApp backend are done via its GraphQL API.

*   **GraphQL Endpoint:** `http://localhost:3000/graphql`
*   **GraphiQL Interface (Development Only):** `http://localhost:3000/graphiql`
*   You can use GraphiQL to explore the schema, test queries, and mutations.

### Authentication

To interact with most of the API, you first need to register and authenticate to obtain a JWT token.

**1. Register a User:**

```graphql
mutation RegisterUser {
  register(name: "Test User", email: "test@example.com", password: "password", passwordConfirmation: "password", role: "customer") {
    message
    errors
  }
}
```

**2. Authenticate (Login) a User:**

```graphql
mutation AuthenticateUser {
  authenticate(email: "test@example.com", password: "password") {
    authToken
    errors
  }
}
```

Upon successful authentication, the `authToken` field will contain your JWT. You must include this token in the `Authorization` header of subsequent GraphQL requests in the format `Bearer YOUR_JWT_TOKEN`.

### Example GraphQL Queries & Mutations

Here are some examples of how to interact with the API. Remember to include your JWT in the `Authorization` header for authenticated requests.

**Create a Ticket (as a Customer):**

```graphql
mutation CreateTicket {
  createTicket(title: "My Printer is Broken", description: "It's making weird noises and not printing.") {
    ticket {
      id
      title
      description
      status
      user {
        email
      }
    }
    errors
  }
}
```

**View Your Tickets (as a Customer):**

```graphql
query GetMyTickets {
  tickets {
    id
    title
    status
    user {
      email
    }
  }
}
```

**View All Tickets (as an Agent):**

```graphql
query GetAllTickets {
  tickets {
    id
    title
    status
    user {
      email
    }
    assignedAgent {
      email
    }
  }
}
```

**Add a Comment to a Ticket (as Agent or Customer after Agent has commented):**

```graphql
mutation AddCommentToTicket {
  createComment(ticketId: "<TICKET_ID>", content: "Thanks for reaching out! I'll look into this.") {
    comment {
      id
      content
      user {
        email
      }
    }
    errors
  }
}
```

**Assign a Ticket to an Agent (as an Agent):**

```graphql
mutation AssignTicket {
  assignTicket(ticketId: "<TICKET_ID>", agentId: "<AGENT_USER_ID>") {
    ticket {
      id
      title
      assignedAgent {
        email
      }
    }
    errors
  }
}
```

**Export Closed Tickets to CSV (as an Agent):**

First, query the URL:

```graphql
query GetClosedTicketsCsvUrl {
  closedTicketsCsvUrl
}
```

Then, make a GET request to the returned URL (e.g., `http://localhost:3000/export_closed_tickets`) to download the CSV file.

**Get Open Tickets for Daily Reminder (as an Agent):**

```graphql
query GetOpenTicketsForAgent {
  openTicketsForAgent {
    id
    title
    status
    user {
      email
    }
  }
}
```

## Testing (Optional)

To run the test suite:

```bash
bundle exec rails test
```

## Further Development & Contribution

Feel free to extend the functionality or contribute to the project. Some areas for further development could include:

*   More advanced filtering and sorting for GraphQL queries.
*   Real-time updates using GraphQL Subscriptions.
*   Integration with external notification services (e.g., email, SMS).
*   Comprehensive error handling and custom error types in GraphQL.
*   Adding more robust validation rules.

---

**Note:** This README provides a basic guide. For detailed API schema and types, refer to the GraphiQL interface (`/graphiql`) or the source code in `app/graphql/`.