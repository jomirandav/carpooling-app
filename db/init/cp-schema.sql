DROP TABLE IF EXISTS "users" CASCADE;
CREATE TABLE "users"(
    "user_id" SERIAL PRIMARY KEY NOT NULL,
    "created_at" TIMESTAMP DEFAULT CURRENT_DATE NOT NULL,
    "updated_at" TIMESTAMP DEFAULT CURRENT_DATE NOT NULL,
    "deleted_at" TIMESTAMP DEFAULT NULL,
    "name" VARCHAR(255) NOT NULL,
    "lastname" VARCHAR(255) NOT NULL,
    "email" VARCHAR(255) UNIQUE NOT NULL,
    "rut" VARCHAR(255) UNIQUE NOT NULL,
    "birthdate" DATE NOT NULL,
    "gender" VARCHAR(255) CHECK
        ("gender" IN('Male', 'Female', 'Other')) NOT NULL,
    "rating" FLOAT8 NOT NULL
);

DROP TABLE IF EXISTS "districts" CASCADE;
CREATE TABLE "districts"(
    "district_id" SERIAL PRIMARY KEY NOT NULL,
    "name" VARCHAR(255) NOT NULL,
    "latitude" FLOAT8 NOT NULL,
    "longitude" FLOAT8 NOT NULL,
    "province" VARCHAR(255) NOT NULL,
    "region" VARCHAR(255) NOT NULL
);

DROP TABLE IF EXISTS "cars" CASCADE;
CREATE TABLE "cars"(
    "car_id" SERIAL PRIMARY KEY NOT NULL,
    "driver_id" INTEGER NOT NULL,
    "brand" VARCHAR(255) NOT NULL,
    "model" VARCHAR(255) NOT NULL,
    "year" INTEGER NOT NULL,
    "average_lpk" FLOAT8 NOT NULL,
    "seats" INTEGER NOT NULL,
    "plate_number" VARCHAR(255) NOT NULL
);

DROP TABLE IF EXISTS "trips" CASCADE;
CREATE TABLE "trips"(
    "trip_id" BIGINT PRIMARY KEY NOT NULL,
    "created_at" TIMESTAMP DEFAULT CURRENT_DATE NOT NULL,
    "updated_at" TIMESTAMP DEFAULT CURRENT_DATE NOT NULL,
    "deleted_at" TIMESTAMP DEFAULT NULL,
    "start_date" DATE NOT NULL,
    "from_district" INTEGER NOT NULL,
    "to_district" INTEGER NOT NULL,
    "distance" FLOAT8 NOT NULL,
    "available_seats" INTEGER NOT NULL,
    "price" FLOAT8 NOT NULL,
    "sugested_price" FLOAT8 NOT NULL,
    "driver_id" INTEGER NOT NULL
);

DROP TABLE IF EXISTS "users_trip" CASCADE;
CREATE TABLE "users_trip"(
    "users_trip_id" SERIAL PRIMARY KEY NOT NULL,
    "trip_id" INTEGER NOT NULL,
    "user_id" INTEGER NOT NULL,
    "driver_rating" FLOAT8 NOT NULL,
    "user_rating" FLOAT8 NOT NULL,
    "driver_comment" TEXT NOT NULL,
    "user_comment" TEXT NOT NULL
);

DROP TABLE IF EXISTS "driver" CASCADE;
CREATE TABLE "driver"(
    "driver_id" SERIAL PRIMARY KEY NOT NULL,
    "user_id" INTEGER UNIQUE NOT NULL,
    "rating" FLOAT8 NOT NULL
);

DROP TABLE IF EXISTS "preferences" CASCADE;
CREATE TABLE "preferences"(
    "preference_id" SERIAL PRIMARY KEY NOT NULL,
    "name" VARCHAR(255) NOT NULL
);

DROP TABLE IF EXISTS "user_preferences" CASCADE;
CREATE TABLE "user_preferences"(
    "user_preferences_id" SERIAL PRIMARY KEY NOT NULL,
    "preference_id" INTEGER NOT NULL,
    "user_id" INTEGER UNIQUE NOT NULL,
    "value" VARCHAR(255) NOT NULL
);


ALTER TABLE
    "trips" ADD CONSTRAINT "trips_driver_id_foreign" FOREIGN KEY("driver_id") REFERENCES "driver"("driver_id");
ALTER TABLE
    "driver" ADD CONSTRAINT "driver_user_id_foreign" FOREIGN KEY("user_id") REFERENCES "users"("user_id");
ALTER TABLE
    "users_trip" ADD CONSTRAINT "users_trip_user_id_foreign" FOREIGN KEY("user_id") REFERENCES "users"("user_id");
ALTER TABLE
    "trips" ADD CONSTRAINT "trips_from_district_foreign" FOREIGN KEY("from_district") REFERENCES "districts"("district_id");
ALTER TABLE
    "trips" ADD CONSTRAINT "trips_to_district_foreign" FOREIGN KEY("to_district") REFERENCES "districts"("district_id");
ALTER TABLE
    "cars" ADD CONSTRAINT "cars_driver_id_foreign" FOREIGN KEY("driver_id") REFERENCES "driver"("driver_id");
ALTER TABLE
    "users_trip" ADD CONSTRAINT "users_trip_trip_id_foreign" FOREIGN KEY("trip_id") REFERENCES "trips"("trip_id");
ALTER TABLE
    "user_preferences" ADD CONSTRAINT "user_preferences_user_id_foreign" FOREIGN KEY("user_id") REFERENCES "users"("user_id");
ALTER TABLE
    "user_preferences" ADD CONSTRAINT "user_preferences_preference_id_foreign" FOREIGN KEY("preference_id") REFERENCES "preferences"("preference_id");