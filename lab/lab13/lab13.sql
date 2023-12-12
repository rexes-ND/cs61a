.read data.sql


CREATE TABLE bluedog AS
  SELECT color, pet FROM students WHERE color = 'blue' AND pet = 'dog';

CREATE TABLE bluedog_songs AS
  SELECT color, pet, song FROM students WHERE color = 'blue' AND pet = 'dog';


CREATE TABLE smallest_int_having AS
  SELECT time, smallest FROM students GROUP BY smallest HAVING count(*) = 1;


CREATE TABLE matchmaker AS
  SELECT first.pet, first.song, first.color, second.color FROM students AS first, students AS second WHERE first.pet = second.pet AND first.song = second.song AND first.time < second.time;


CREATE TABLE sevens AS
  SELECT seven FROM students, numbers WHERE smallest <= 7 AND numbers.'7' = 'True' AND students.time = numbers.time;

