/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
id INT,
name TEXT,
date_of_birth DATE,
escape_attempts INT,
neutered BIT,
weight_kg DECIMAL(8,2)
);
