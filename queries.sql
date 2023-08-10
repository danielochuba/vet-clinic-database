/*Queries that provide answers to the questions from all projects.*/

 EXPLAIN ANALYZE SELECT COUNT(*) FROM visits where animal_id = 4;
 EXPLAIN ANALYZE SELECT * FROM visits where vet_id = 2;
 EXPLAIN ANALYZE SELECT * FROM owners where email = 'owner_18327@mail.com';
 EXPLAIN ANALYZE SELECT * FROM owners where age = 28;
 EXPLAIN ANALYZE SELECT COUNT(*) FROM owners where age <= 30;
 EXPLAIN ANALYZE SELECT COUNT(*) FROM visits where vet_id >= 10;
