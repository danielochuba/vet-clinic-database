/*Queries that provide answers to the questions from all projects.*/

 EXPLAIN ANALYZE SELECT COUNT(*) FROM visits where animal_id = 4;
 EXPLAIN ANALYZE SELECT * FROM visits where vet_id = 2;
 EXPLAIN ANALYZE SELECT * FROM owners where email = 'owner_18327@mail.com';
