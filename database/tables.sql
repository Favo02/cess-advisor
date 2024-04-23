CREATE TABLE users (
  id            uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  username      TEXT NOT NULL UNIQUE CHECK (username ~ '^[a-zA-Z0-9]{4,16}$'),
  password      TEXT NOT NULL
);

CREATE TABLE toilets (
  id            uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  creator       uuid NOT NULL REFERENCES users(id),
  creation      TIMESTAMPTZ NOT NULL DEFAULT now(),
  title         TEXT NOT NULL CHECK (title ~ '^[\t\n\x20-\xFF]{6,50}$'),
  university    TEXT NOT NULL CHECK (university ~ '^[\t\n\x20-\xFF]{6,50}$'),
  building      TEXT NOT NULL CHECK (building ~ '^[\t\n\x20-\xFF]{6,50}$'),
  place         TEXT NOT NULL CHECK (place ~ '^[\t\n\x20-\xFF]{6,50}$'),
  description   TEXT NOT NULL CHECK (description ~ '^[\t\n\x20-\xFF]{6,250}$')
);

CREATE TABLE reviews (
  id            uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  author        uuid NOT NULL REFERENCES users(id),
  date          TIMESTAMPTZ NOT NULL DEFAULT now(),
  toilet        uuid NOT NULL REFERENCES toilets(id),
  rating        INT NOT NULL CHECK (rating >= 0 AND rating <= 10),
  description   TEXT NOT NULL CHECK (description ~ '^[\t\n\x20-\xFF]{6,250}$'),
  paper         BOOLEAN NOT NULL,
  soap          BOOLEAN NOT NULL,
  dryer         BOOLEAN NOT NULL,
  hotwater      BOOLEAN NOT NULL,
  clean         INT NOT NULL CHECK (clean >= 0 AND clean <= 10),
  temperature   INT NOT NULL CHECK (temperature >= 0 AND temperature <= 10)
);
