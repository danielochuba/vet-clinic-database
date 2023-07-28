/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
id INT PRIMARY KEY NOT NULL,
name VARCHAR(10),
date_of_birth DATE,
escape_attempts INT,
neutered BOOLEAN,
weight_kg DECIMAL(8,2)
);

ALTER TABLE animals ADD COLUMN species VARCHAR(20);

CREATE TABLE owners (
id SERIAL PRIMARY KEY,
full_name VARCHAR(100) NOT NULL,
age INT NOT NULL
);

CREATE TABLE species (
id SERIAL PRIMARY KEY,
name VARCHAR(100)
);

CREATE SEQUENCE animals_id_seq START 11;
ALTER TABLE animals ALTER COLUMN id SET DEFAULT nextval('animals_id_seq');
UPDATE animals SET id = nextval('animals_id_seq');

ALTER TABLE animals DROP COLUMN species;

ALTER TABLE animals ADD COLUMN species_id INT;
ALTER TABLE animals ADD CONSTRAINT species_fkey FOREIGN KEY (species_id) REFERENCES species(id);

ALTER TABLE animals ADD COLUMN owner_id INT;
ALTER TABLE animals ADD CONSTRAINT owners_fkey FOREIGN KEY (owner_id) REFERENCES owners(id);

