/*markdown
## SQL Murder Mystery ##
*/

/*markdown
![image](https://mystery.knightlab.com/174092-clue-illustration.png)
[SQL Murder Mystery](https://mystery.knightlab.com/)
*/

/*markdown
There's been a Murder in SQL City! The SQL Murder Mystery is designed to be both a self-directed lesson to learn SQL concepts and commands and a fun game for experienced SQL users to solve an intriguing crime.
A crime has taken place and the detective needs your help. The detective gave you the crime scene report, but you somehow lost it. You vaguely remember that the crime was a **​murder**​ that occurred sometime on **​Jan.15, 2018**​ and that it took place in **​SQL City**​. Start by retrieving the corresponding crime scene report from the police department’s database.
*/

/*markdown
**Schema**
*/

/*markdown
![schema](https://mystery.knightlab.com/schema.png)
*/

/*markdown
## My Solution ##
*/

/*markdown
**Get The Crime Report**
*/

SELECT * 
  FROM crime_scene_report
 WHERE date = '20180115' 
   AND type = 'murder' 
   AND city LIKE 'SQL%';

/*markdown
**Find The Witnesses**
*/

SELECT * 
  FROM person
 WHERE address_street_name LIKE '%Northwestern%'
 ORDER BY address_number DESC
 LIMIT 1;

SELECT * 
  FROM person
 WHERE address_street_name LIKE '%Franklin%' 
   AND name LIKE '%Annabel%'

/*markdown
**Get The Witness Statements**
*/

SELECT *
  FROM interview
 WHERE person_id IN (14887, 16371);

/*markdown
**Track Down The Car**
*/

SELECT *
  FROM drivers_license
 WHERE plate_number LIKE '%H42W%';

/*markdown
**Who Owns The Car**
*/

SELECT *
  FROM person
 WHERE license_id IN (183779,423327,664760);

/*markdown
**Investigate The Gym**
*/

SELECT *
  FROM get_fit_now_member
 WHERE id LIKE '48Z%';

SELECT *
  FROM get_fit_now_check_in
 WHERE check_in_date = '20180109' 
   AND membership_id LIKE '48Z%';

SELECT *
  FROM person
 WHERE id IN (67318, 28819);

/*markdown
**Did We Find The Killer?**
*/

INSERT INTO solution VALUES (1, 'Jeremy Bowers');
SELECT value FROM solution;

/*markdown
**Interview The Suspect**
*/

SELECT *
  FROM interview
 WHERE person_id = 67318;

/*markdown
**Follow New Lead**
*/

SELECT *
  FROM drivers_license
 WHERE gender = 'female' 
   AND car_make = 'Tesla' 
   AND car_model = 'Model S' 
   AND hair_color = 'red';

/*markdown
**Check Attendance of Symphony**
*/

SELECT person_id, event_name, COUNT(event_id) as 'Attended'
  FROM facebook_event_checkin
 WHERE event_name LIKE '%SQL Symphony Concert%' 
   AND date LIKE '201712__'
 GROUP BY person_id
HAVING Attended = 3;

/*markdown
**Match Licence Number to Person**
*/

SELECT *
  FROM person
 WHERE license_id IN (202298,24556);

/*markdown
**Did We Find The Brains?**
*/

INSERT INTO solution VALUES (1, 'Miranda Priestly');
SELECT value FROM solution;