CREATE TABLE users (
  id        uuid  PRIMARY KEY DEFAULT gen_random_uuid(),
  username  TEXT  NOT NULL UNIQUE,
  password  TEXT  NOT NULL
);

CREATE TABLE toilets (
  id      uuid  PRIMARY KEY DEFAULT gen_random_uuid(),
  name    TEXT  NOT NULL,
  place   TEXT  NOT NULL,
  floor   INT   NOT NULL,
  creator uuid  NOT NULL REFERENCES users(id)
);

CREATE TABLE reviews (
  id                uuid    PRIMARY KEY DEFAULT gen_random_uuid(),
  author            uuid    NOT NULL REFERENCES users(id),
  date              DATE    NOT NULL,
  toilet            uuid    NOT NULL REFERENCES toilets(id),
  rating            INT     NOT NULL,
  description       TEXT    NOT NULL
);
