CREATE TABLE users (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  username TEXT NOT NULL UNIQUE,
  password TEXT NOT NULL
);

-- CREATE TABLE buildings (
--   id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
--   name TEXT NOT NULL,
--   address TEXT,
--   description TEXT,
--   creator uuid REFERENCES users(id)
-- );

-- CREATE TABLE toilets (
--   id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
--   name TEXT,
--   building uuid REFERENCES buildings(id),
--   floor INT,
--   directions TEXT,
--   creator uuid REFERENCES users(id)
-- );

-- CREATE TABLE reviews (
--   id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
--   author uuid REFERENCES users(id),
--   toilet uuid REFERENCES toilets(id),
--   description TEXT,
--   cleanliness INT,
--   toilet_paper BOOLEAN,
--   hot_water BOOLEAN,
--   soap BOOLEAN,
--   room_temperature INT
-- );