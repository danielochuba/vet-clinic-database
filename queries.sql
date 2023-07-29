/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name LIKE '%mon';

SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';

SELECT name FROM animals WHERE neutered = TRUE AND escape_attempts < 3;

SELECT date_of_birth FROM animals WHERE name IN ('Agumon', 'Pikachu');

SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;

SELECT * FROM animals WHERE neutered = TRUE;

SELECT * FROM animals WHERE name <> 'Gabumon';

SELECT * FROM animals WHERE weight_kg BETWEEN 10.4 AND 17.3;


BEGIN;
UPDATE animals SET species = 'unspecified';
SELECT * FROM animals;
ROLLBACK;
SELECT * FROM animals;

BEGIN;
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';
UPDATE animals SET species = 'pokemon' WHERE species IS NULL OR species = '';
SELECT * FROM animals;
COMMIT;
SELECT * FROM animals;

BEGIN;
DELETE FROM animals;
ROLLBACK;
SELECT * FROM animals;

BEGIN;
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
SAVEPOINT savepoint_1;
UPDATE animals SET weight_kg = -1 * weight_kg;
ROLLBACK TO SAVEPOINT savepoint_1;
UPDATE animals SET weight_kg = -1 * weight_kg WHERE weight_kg < 0;
COMMIT;

SELECT COUNT(*) FROM animals;
SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;
SELECT AVG(weight_kg) FROM animals;
SELECT neutered, MAX(escape_attempts) AS escape_attempts FROM animals GROUP BY neutered;
SELECT MAX(weight_kg), MIN(weight_kg) FROM animals GROUP BY species;
SELECT species, AVG(escape_attempts) AS avg_escape_attempts FROM animals WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31' GROUP BY species;

/* What animals belong to Melody Pond? */
SELECT animals.name
FROM animals
INNER JOIN owners ON animals.owner_id = owners.id
WHERE owners.full_name = 'Melody Pond';

SELECT animals.name
FROM animals
INNER JOIN species ON animals.species_id = species.id
WHERE species.name = 'Pokemon';

SELECT owners.full_name, animals.name
FROM owners
LEFT JOIN animals ON owners.id = animals.owner_id;

/* How many animals are there per species? */
SELECT species.name, COUNT(animals.id) AS animal_count
FROM species
LEFT JOIN animals ON species.id = animals.species_id
GROUP BY species.name;

SELECT animals.name
FROM animals
INNER JOIN species ON animals.species_id = species.id
INNER JOIN owners ON animals.owner_id = owners.id
WHERE species.name = 'Digimon' AND owners.full_name = 'Jennifer Orwell';

SELECT animals.name
FROM animals
INNER JOIN owners ON animals.owner_id = owners.id
WHERE owners.full_name = 'Dean Winchester' AND animals.escape_attempts = 0;

SELECT owners.full_name, COUNT(animals.id) AS animal_count
FROM owners
LEFT JOIN animals ON owners.id = animals.owner_id
GROUP BY owners.full_name
ORDER BY animal_count DESC
LIMIT 1;



SELECT a.name AS last_animal_seen
FROM animals a
INNER JOIN visits v ON a.id = v.animals_id
INNER JOIN vets vt ON v.vets_id = vt.id
WHERE vt.name = 'William Tatcher'
ORDER BY v.date_of_visit DESC
LIMIT 1;

SELECT COUNT(DISTINCT v.animals_id) AS num_different_animals_seen
FROM visits v
INNER JOIN vets vt ON v.vets_id = vt.id
WHERE vt.name = 'Stephanie Mendez';

SELECT vt.name AS vet_name, s.species_id AS specialty
FROM vets vt
LEFT JOIN specializations s ON vt.id = s.vets_id;

SELECT a.name AS animal_name, v.date_of_visit
FROM animals a
INNER JOIN visits v ON a.id = v.animals_id
INNER JOIN vets vt ON v.vets_id = vt.id
WHERE vt.name = 'Stephanie Mendez'
AND v.date_of_visit BETWEEN '2020-04-01' AND '2020-08-30';

SELECT a.name AS animal_name, COUNT(v.animals_id) AS num_visits
FROM animals a
INNER JOIN visits v ON a.id = v.animals_id
GROUP BY a.id
ORDER BY num_visits DESC
LIMIT 1;

SELECT a.name AS animal_name, v.date_of_visit
FROM animals a
INNER JOIN visits v ON a.id = v.animals_id
INNER JOIN vets vt ON v.vets_id = vt.id
WHERE vt.name = 'Maisy Smith'
ORDER BY v.date_of_visit ASC
LIMIT 1;

SELECT a.name AS animal_name, vt.name AS vet_name, v.date_of_visit
FROM animals a
INNER JOIN visits v ON a.id = v.animals_id
INNER JOIN vets vt ON v.vets_id = vt.id
ORDER BY v.date_of_visit DESC
LIMIT 1;

SELECT COUNT(*) AS num_visits_no_specialty
FROM visits v
INNER JOIN animals a ON v.animals_id = a.id
INNER JOIN vets vt ON v.vets_id = vt.id
LEFT JOIN specializations s ON vt.id = s.vets_id AND a.species_id = s.species_id
WHERE s.species_id IS NULL;

SELECT a.species_id, species.name, COUNT(*) AS num_visits
FROM animals a
INNER JOIN visits v ON a.id = v.animals_id
INNER JOIN vets vt ON v.vets_id = vt.id
INNER JOIN species ON a.species_id = species.id
WHERE vt.name = 'Vet Maisy Smith'
GROUP BY a.species_id, species.name
ORDER BY num_visits DESC
LIMIT 1;
