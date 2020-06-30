CREATE SCHEMA public;

CREATE extension IF NOT EXISTS "uuid-ossp";

CREATE TABLE sample(
                       id  uuid PRIMARY KEY DEFAULT uuid_generate_v4(),
                       some_name VARCHAR(200) NOT NULL,
                       some_time TIMESTAMP NOT NULL,
                       some_status VARCHAR(20) NOT NULL,
                       some_number INTEGER NOT NULL
);

INSERT INTO sample(some_name, some_time, some_status, some_number) SELECT MD5(random()::text),
                                                                          timestamp '2018-01-10 20:00:00' +
                                                                          random() * (timestamp '2020-06-20 20:00:00' -
                                                                                      timestamp '2018-01-10 10:00:00'),'PROCESSED', floor(random() * 1000000 + 1)::int
FROM generate_series(1, 3000000);

INSERT INTO sample(some_name, some_time, some_status, some_number) SELECT MD5(random()::text),
                                                                          timestamp '2018-01-10 20:00:00' +
                                                                          random() * (timestamp '2020-06-20 20:00:00' -
                                                                                      timestamp '2018-01-10 10:00:00'),'PENDING', floor(random() * 1000000 + 1)::int
FROM generate_series(1, 3000000);


-- create usual index
CREATE INDEX some_name_some_time_some_status_index on sample(some_name,some_time, some_status);

-- create ordered index
CREATE INDEX some_name_some_time_some_status_ordered_index on sample(some_name, some_time ASC, some_status);
