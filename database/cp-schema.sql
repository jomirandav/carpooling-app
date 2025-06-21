CREATE TABLE "users"(
    "user_id" SERIAL NOT NULL,
    "created_at" DATE NOT NULL,
    "updated_at" DATE NOT NULL,
    "name" VARCHAR(255) NOT NULL,
    "lastname" VARCHAR(255) NOT NULL,
    "rut" VARCHAR(255) NOT NULL,
    "birthdate" DATE NOT NULL,
    "gender" VARCHAR(255) CHECK
        ("gender" IN('')) NOT NULL,
        "email" VARCHAR(255) NOT NULL,
        "rating" FLOAT(53) NOT NULL
);
ALTER TABLE
    "users" ADD PRIMARY KEY("user_id");
CREATE TABLE "districts"(
    "district_id" SERIAL NOT NULL,
    "name" VARCHAR(255) NOT NULL,
    "latitude" FLOAT(53) NOT NULL,
    "longitude" FLOAT(53) NOT NULL,
    "province" VARCHAR(255) NOT NULL,
    "region" VARCHAR(255) NOT NULL
);
ALTER TABLE
    "districts" ADD PRIMARY KEY("district_id");
CREATE TABLE "cars"(
    "car_id" SERIAL NOT NULL,
    "driver_id" INTEGER NOT NULL,
    "brand" VARCHAR(255) NOT NULL,
    "model" VARCHAR(255) NOT NULL,
    "year" INTEGER NOT NULL,
    "average_lpk" FLOAT(53) NOT NULL,
    "seats" INTEGER NOT NULL,
    "plate_number" VARCHAR(255) NOT NULL
);
ALTER TABLE
    "cars" ADD PRIMARY KEY("car_id");
CREATE TABLE "trips"(
    "trip_id" BIGINT NOT NULL,
    "created_at" DATE NOT NULL,
    "updated_at" DATE NOT NULL,
    "start_date" DATE NOT NULL,
    "from_district" INTEGER NOT NULL,
    "to_district" INTEGER NOT NULL,
    "distance" FLOAT(53) NOT NULL,
    "available_seats" INTEGER NOT NULL,
    "price" FLOAT(53) NOT NULL,
    "sugested_price" FLOAT(53) NOT NULL,
    "driver_id" INTEGER NOT NULL
);
ALTER TABLE
    "trips" ADD PRIMARY KEY("trip_id");
CREATE TABLE "users_trip"(
    "users_trip_id" SERIAL NOT NULL,
    "trip_id" INTEGER NOT NULL,
    "user_id" INTEGER NOT NULL,
    "driver_rating" FLOAT(53) NOT NULL,
    "user_rating" FLOAT(53) NOT NULL,
    "driver_comment" TEXT NOT NULL,
    "user_comment" TEXT NOT NULL
);
ALTER TABLE
    "users_trip" ADD PRIMARY KEY("users_trip_id");
CREATE TABLE "driver"(
    "driver_id" SERIAL NOT NULL,
    "user_id" INTEGER NOT NULL,
    "rating" FLOAT(53) NOT NULL
);
ALTER TABLE
    "driver" ADD PRIMARY KEY("driver_id");
CREATE TABLE "preferences"(
    "preference_id" SERIAL NOT NULL,
    "user_id" INTEGER NOT NULL,
    "music" VARCHAR(255) NOT NULL,
    "pet_friendly" BOOLEAN NOT NULL,
    "driver_gender" VARCHAR(255) CHECK
        ("driver_gender" IN('')) NOT NULL,
        "communication_style" VARCHAR(255)
    CHECK
        ("communication_style" IN('')) NOT NULL
);
ALTER TABLE
    "preferences" ADD PRIMARY KEY("preference_id");
ALTER TABLE
    "trips" ADD CONSTRAINT "trips_driver_id_foreign" FOREIGN KEY("driver_id") REFERENCES "driver"("driver_id");
ALTER TABLE
    "driver" ADD CONSTRAINT "driver_user_id_foreign" FOREIGN KEY("user_id") REFERENCES "users"("user_id");
ALTER TABLE
    "preferences" ADD CONSTRAINT "preferences_user_id_foreign" FOREIGN KEY("user_id") REFERENCES "users"("user_id");
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