/*markdown
https://github.com/JasonMuteham/sql-mysteries
*/

/*markdown
## SQL Murder Mystery Solution ##
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

SELECT date Date, type Crime, description Details 
  FROM crime_scene_report
 WHERE date = '20180115' 
   AND type = 'murder' 
   AND city LIKE 'SQL%';

/*markdown
**Find The Witnesses**
*/

SELECT name Name, id 'Person ID', address_number 'House No', address_street_name 'Street Name' 
  FROM person
 WHERE address_street_name LIKE '%Northwestern%'
   AND (SELECT MAX(address_number) 
          FROM person 
         WHERE address_street_name LIKE '%Northwestern%') = address_number
 UNION
SELECT name Name, id, address_number 'House No', address_street_name 'Street Name'
  FROM person
 WHERE address_street_name LIKE '%Franklin%' 
   AND name LIKE '%Annabel%'

/*markdown
**Get The Witness Statements**
*/

SELECT p.name AS 'Name', i.transcript AS Statement
  FROM interview AS i
  JOIN person AS p
    ON i.person_id = p.id
 WHERE i.person_id IN (SELECT id 
                         FROM person
                        WHERE address_street_name LIKE '%Northwestern%'
                          AND (SELECT MAX(address_number) 
                                 FROM person 
                                WHERE address_street_name LIKE '%Northwestern%') = address_number
                        UNION
                       SELECT id
                        FROM person
                       WHERE address_street_name LIKE '%Franklin%' 
                         AND name LIKE '%Annabel%')

/*markdown
**Track Down The Car and Owner**
*/

SELECT p.name Name, d.plate_number 'Plate Number', d.car_make Make, d.car_model Model 
  FROM drivers_license AS d
  JOIN person AS p
    ON d.id = p.license_id
 WHERE plate_number LIKE '%H42W%'
   AND d.gender = 'male';

/*markdown
**Investigate The Gym**
*/

SELECT name Name, membership_id 'Gym ID', check_in_date Date, check_in_time 'Time in', check_out_time 'Time out'
  FROM get_fit_now_check_in
  JOIN get_fit_now_member
    ON membership_id = id
 WHERE check_in_date = '20180109' 
   AND membership_id LIKE '48Z%';

/*markdown
**Compare Suspect Drivers with Gym Membership**
*/

SELECT person_id AS 'Person ID', name AS 'The Murder Is' 
  FROM get_fit_now_check_in
  JOIN get_fit_now_member
    ON membership_id = id
 WHERE check_in_date = '20180109' 
   AND membership_id LIKE '48Z%'
   AND name IN (SELECT p.name 
                  FROM drivers_license AS d
                  JOIN person AS p
                    ON d.id = p.license_id
                 WHERE plate_number LIKE '%H42W%'
                   AND d.gender = 'male');

/*markdown
**Did We Find The Killer?**
*/

INSERT INTO solution VALUES (1, 'Jeremy Bowers');
SELECT value as 'Solved?'
  FROM solution;

/*markdown
**Interview The Suspect**
*/

SELECT name Name, transcript 'Suspect Statement'
  FROM interview
  JOIN person
    ON person_id = id
 WHERE person_id = 67318;

/*markdown
**Follow New Lead**
*/

SELECT name 'The Master Mind Behind The Crime Is'
  FROM drivers_license d
  JOIN person AS p
    ON d.id = p.license_id
  JOIN income i
    ON p.ssn = i.ssn
 WHERE gender = 'female' 
   AND car_make = 'Tesla' 
   AND car_model = 'Model S' 
   AND hair_color = 'red'
   AND p.id IN (SELECT person_id
                  FROM facebook_event_checkin
                 WHERE event_name LIKE '%SQL Symphony Concert%' 
                   AND date LIKE '201712__'
                 GROUP BY person_id
                HAVING COUNT(event_id) = 3)

/*markdown
**Did We Find The Brains Behind The Crime?**
*/

INSERT INTO solution VALUES (1, 'Miranda Priestly');
SELECT value 'Solved?' FROM solution;