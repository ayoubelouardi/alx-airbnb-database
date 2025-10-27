-- This script creates the database schema for the Airbnb Clone project.
-- Dialect: PostgreSQL

-- 0. Create ENUM Types
-- ENUMs are created first as they are custom types that will be referenced by tables.
CREATE TYPE user_role AS ENUM ('guest', 'host', 'admin');
CREATE TYPE booking_status AS ENUM ('pending', 'confirmed', 'canceled');
CREATE TYPE payment_method_type AS ENUM ('credit_card', 'paypal', 'stripe');

-- 1. Create User Table
-- "User" is quoted because USER is a reserved keyword in SQL.
CREATE TABLE "User" (
    user_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    phone_number VARCHAR(50),
    role user_role NOT NULL DEFAULT 'guest',
    created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP
);

-- 2. Create Property Table
CREATE TABLE Property (
    property_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    host_id UUID NOT NULL REFERENCES "User"(user_id) ON DELETE CASCADE,
    name VARCHAR(255) NOT NULL,
    description TEXT NOT NULL,
    location VARCHAR(255) NOT NULL,
    pricepernight DECIMAL(10, 2) NOT NULL CHECK (pricepernight > 0),
    created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP
);

-- 3. Create Booking Table
CREATE TABLE Booking (
    booking_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    property_id UUID NOT NULL REFERENCES Property(property_id) ON DELETE RESTRICT,
    user_id UUID NOT NULL REFERENCES "User"(user_id) ON DELETE RESTRICT,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    total_price DECIMAL(10, 2) NOT NULL,
    status booking_status NOT NULL DEFAULT 'pending',
    created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT check_dates CHECK (end_date > start_date)
);

-- 4. Create Payment Table
CREATE TABLE Payment (
    payment_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    booking_id UUID NOT NULL REFERENCES Booking(booking_id) ON DELETE RESTRICT,
    amount DECIMAL(10, 2) NOT NULL,
    payment_date TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    payment_method payment_method_type NOT NULL
);

-- 5. Create Review Table
CREATE TABLE Review (
    review_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    property_id UUID NOT NULL REFERENCES Property(property_id) ON DELETE CASCADE,
    user_id UUID NOT NULL REFERENCES "User"(user_id) ON DELETE SET NULL,
    rating INTEGER NOT NULL CHECK (rating >= 1 AND rating <= 5),
    comment TEXT NOT NULL,
    created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP
);

-- 6. Create Message Table
CREATE TABLE Message (
    message_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    sender_id UUID NOT NULL REFERENCES "User"(user_id) ON DELETE SET NULL,
    recipient_id UUID NOT NULL REFERENCES "User"(user_id) ON DELETE SET NULL,
    message_body TEXT NOT NULL,
    sent_at TIMESTAMT_Z DEFAULT CURRENT_TIMESTAMP
);

-- 7. Create Trigger Function for updated_at
-- This function automatically updates the 'updated_at' timestamp on any row update.
CREATE OR REPLACE FUNCTION trigger_set_timestamp()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Apply the trigger to the Property table
CREATE TRIGGER set_timestamp
BEFORE UPDATE ON Property
FOR EACH ROW
EXECUTE PROCEDURE trigger_set_timestamp();

-- 8. Create Indexes for Performance
-- Primary keys are automatically indexed. These are additional indexes
-- for foreign keys and frequently queried columns as per the specification.
CREATE INDEX ON "User" (email);
CREATE INDEX ON Property (host_id);
CREATE INDEX ON Booking (property_id);
CREATE INDEX ON Booking (user_id);
CREATE INDEX ON Payment (booking_id);
CREATE INDEX ON Review (property_id);
CREATE INDEX ON Review (user_id);
CREATE INDEX ON Message (sender_id);
CREATE INDEX ON Message (recipient_id);

