# Database Entity-Relationship Diagram (ERD)

This document provides the Entity-Relationship Diagram (ERD) for the Airbnb Clone database. The diagram is generated using **Mermaid.js** and visualizes the database schema, including all entities (tables), their attributes, and their relationships.

---

## 1. Entities (Tables)

The database is composed of six primary entities:

* **User:** Stores information about all users (guests, hosts, and admins).
* **Property:** Contains all details about a property listing, linked to a `host_id`.
* **Booking:** Manages reservations, linking a `User` (guest) to a `Property`.
* **Payment:** Stores transaction data, linked directly to a `Booking`.
* **Review:** Stores ratings and comments, linking a `User` to a `Property`.
* **Message:** Manages chat messages between two `Users` (sender and recipient).

---

## 2. Key Relationships

The relationships define the business logic of the application:

* **User ↔ Property (One-to-Many):** One `User` (as a Host) can own many `Properties`.
* **User ↔ Booking (One-to-Many):** One `User` (as a Guest) can make many `Bookings`.
* **Property ↔ Booking (One-to-Many):** One `Property` can have many `Bookings`.
* **User ↔ Review (One-to-Many):** One `User` can write many `Reviews`.
* **Property ↔ Review (One-to-Many):** One `Property` can receive many `Reviews`.
* **Booking ↔ Payment (One-to-Many):** One `Booking` can have one or more `Payments` (though typically one).
* **User ↔ Message (One-to-Many):** One `User` can be the sender or recipient of many `Messages`.

---

## 3. Mermaid ERD Code

This code block renders the visual diagram when pasted into a compatible Markdown viewer (like GitHub or GitLab).

```mermaid
erDiagram
    User {
        UUID user_id PK "Indexed"
        VARCHAR first_name "NOT NULL"
        VARCHAR last_name "NOT NULL"
        VARCHAR email UK "UNIQUE, NOT NULL"
        VARCHAR password_hash "NOT NULL"
        VARCHAR phone_number "NULL"
        ENUM role "NOT NULL (guest, host, admin)"
        TIMESTAMP created_at
    }

    Property {
        UUID property_id PK "Indexed"
        UUID host_id FK "References User"
        VARCHAR name "NOT NULL"
        TEXT description "NOT NULL"
        VARCHAR location "NOT NULL"
        DECIMAL pricepernight "NOT NULL"
        TIMESTAMP created_at
        TIMESTAMP updated_at
    }

    Booking {
        UUID booking_id PK "Indexed"
        UUID property_id FK "References Property"
        UUID user_id FK "References User (Guest)"
        DATE start_date "NOT NULL"
        DATE end_date "NOT NULL"
        DECIMAL total_price "NOT NULL"
        ENUM status "NOT NULL (pending, confirmed, canceled)"
        TIMESTAMP created_at
    }

    Payment {
        UUID payment_id PK "Indexed"
        UUID booking_id FK "References Booking"
        DECIMAL amount "NOT NULL"
        TIMESTAMP payment_date
        ENUM payment_method "NOT NULL"
    }

    Review {
        UUID review_id PK "Indexed"
        UUID property_id FK "References Property"
        UUID user_id FK "References User (Guest)"
        INTEGER rating "NOT NULL, CHECK (1-5)"
        TEXT comment "NOT NULL"
        TIMESTAMP created_at
    }

    Message {
        UUID message_id PK "Indexed"
        UUID sender_id FK "References User"
        UUID recipient_id FK "References User"
        TEXT message_body "NOT NULL"
        TIMESTAMP sent_at
    }

    %% --- Defining Relationships ---

    User ||--o{ Property : "hosts (as Host)"
    User ||--o{ Booking : "makes (as Guest)"
    User ||--o{ Review : "writes (as Guest)"
    User ||--o{ Message : "sends (as Sender)"
    User ||--o{ Message : "receives (as Recipient)"

    Property ||--o{ Booking : "is_for"
    Property ||--o{ Review : "receives_reviews_for"

    Booking ||--|{ Payment : "has"
