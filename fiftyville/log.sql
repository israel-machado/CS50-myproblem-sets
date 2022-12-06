-- Keep a log of any SQL queries you execute as you solve the mystery.
-- list of tables:
--airports              crime_scene_reports   people
--atm_transactions      flights               phone_calls
--bakery_security_logs  interviews
--bank_accounts         passengers

--Checking crime scene
SELECT id, description FROM crime_scene_reports
WHERE day = 28 AND month = 7 AND year = 2021 AND street = 'Humphrey Street';
A:--  295 | Theft of the CS50 duck took place at 10:15am at the Humphrey Street bakery.
-- Interviews were conducted today with three witnesses who were present at the time –
-- each of their interview transcripts mentions the bakery. |

-- 297 | Littering took place at 16:36. No known witnesses.

-- Checking the interviews
SELECT id, name, transcript FROM interviews
WHERE day = 28 AND month = 7;
--| 158 | Jose    | “Ah,” said he, “I forgot that I had not seen you for some weeks.
--It is a little souvenir from the King of Bohemia in return for my assistance in the case of the Irene Adler papers.”                                                                                                                               |
--| 159 | Eugene  | “I suppose,” said Holmes, “that when Mr. Windibank came back from
--France he was very annoyed at your having gone to the ball.”                                                                                                                                                                                      |
--| 160 | Barbara | “You had my note?” he asked with a deep harsh voice and a strongly marked German accent.
-- “I told you that I would call.” He looked from one to the other of us, as if uncertain which to address.                                                                                                                   |
--| 161 | Ruth    | Sometime within ten minutes of the theft, I saw the thief get into a car in the bakery parking lot and drive away.
-- If you have security footage from the bakery parking lot, you might want to look for cars that left the parking lot in that time frame.                                                          |
--| 162 | Eugene  | I don't know the thief's name, but it was someone I recognized.
--Earlier this morning, before I arrived at Emma's bakery, I was walking by the ATM on Leggett Street and saw the thief there withdrawing some money.                                                                                                 |
--| 163 | Raymond | As the thief was leaving the bakery, they called someone who talked to them for less than a minute.
--In the call, I heard the thief say that they were planning to take the earliest flight out of Fiftyville tomorrow.
-- The thief then asked the person on the other end of the phone to purchase the flight ticket. |
--| 191 | Lily    | Our neighboring courthouse has a very annoying rooster that crows loudly at 6am every day.
-- My sons Robert and Patrick took the rooster to a city far, far away, so it may never bother us again. My sons have successfully arrived in Paris.

--Checking the license plate
SELECT id, activity, minute, license_plate FROM bakery_security_logs
WHERE day = 28 AND month = 7 AND hour = 10;

--| 260 | exit     | 16     | 5P2BI95       |
--| 261 | exit     | 18     | 94KL13X       |
--| 262 | exit     | 18     | 6P58WS2       |
--| 263 | exit     | 19     | 4328GD8       |
--| 264 | exit     | 20     | G412CB7       |
--| 265 | exit     | 21     | L93JTIZ       |
--| 266 | exit     | 23     | 322W7JE       |
--| 267 | exit     | 23     | 0NTHK55       |

--Checking the ATM transation
SELECT id, account_number, transaction_type, amount FROM atm_transactions
WHERE atm_location = 'Leggett Street' AND day = 28 AND month = 7 AND year = 2021;

--+-----+----------------+------------------+--------+
--| id  | account_number | transaction_type | amount |
--+-----+----------------+------------------+--------+
--| 246 | 28500762       | withdraw         | 48     |
--| 264 | 28296815       | withdraw         | 20     |
--| 266 | 76054385       | withdraw         | 60     |
--| 267 | 49610011       | withdraw         | 50     |
--| 269 | 16153065       | withdraw         | 80     |
--| 275 | 86363979       | deposit          | 10     |
--| 288 | 25506511       | withdraw         | 20     |
--| 313 | 81061156       | withdraw         | 30     |
--| 336 | 26013199       | withdraw         | 35     |

--Checking the bank account
SELECT person_id, creation_year FROM bank_accounts WHERE account_number IN
(SELECT account_number FROM atm_transactions
WHERE atm_location = 'Leggett Street' AND day = 28 AND month = 7 AND year = 2021 AND transaction_type = 'withdraw');

--+-----------+---------------+
--| person_id | creation_year |
--+-----------+---------------+
--| 686048    | 2010          |
--| 514354    | 2012          |
--| 458378    | 2012          |
--| 395717    | 2014          |
--| 396669    | 2014          |
--| 467400    | 2014          |
--| 449774    | 2015          |
--| 438727    | 2018          |
--+-----------+---------------+

--Checking the Phone call
SELECT id, caller, receiver, duration FROM phone_calls
WHERE day = 28 AND month = 7 AND year = 2021 and duration <= 60 ORDER BY duration;

--+-----+----------------+----------------+----------+
--| id  |     caller     |    receiver    | duration |
--+-----+----------------+----------------+----------+
--| 224 | (499) 555-9472 | (892) 555-8872 | 36       |
--| 261 | (031) 555-6622 | (910) 555-3251 | 38       |
--| 254 | (286) 555-6063 | (676) 555-6554 | 43       |
--| 233 | (367) 555-5533 | (375) 555-8161 | 45       |
--| 255 | (770) 555-1861 | (725) 555-3243 | 49       |
--| 251 | (499) 555-9472 | (717) 555-1342 | 50       |
--| 221 | (130) 555-0289 | (996) 555-8899 | 51       |
--| 281 | (338) 555-6650 | (704) 555-2131 | 54       |
--| 279 | (826) 555-1652 | (066) 555-9701 | 55       |
--| 234 | (609) 555-5876 | (389) 555-5198 | 60       |
--+-----+----------------+----------------+----------+

--Identifying the account owner and the caller

SELECT * FROM people WHERE id IN
    (SELECT person_id FROM bank_accounts
    WHERE account_number IN
        (SELECT account_number FROM atm_transactions
        WHERE atm_location = 'Leggett Street' AND day = 28 AND month = 7 AND year = 2021 AND transaction_type = 'withdraw'));
--+--------+---------+----------------+-----------------+---------------+
--|   id   |  name   |  phone_number  | passport_number | license_plate |
--+--------+---------+----------------+-----------------+---------------+
--| 395717 | Kenny   | (826) 555-1652 | 9878712108      | 30G67EN       |
--| 396669 | Iman    | (829) 555-5269 | 7049073643      | L93JTIZ       |
--| 438727 | Benista | (338) 555-6650 | 9586786673      | 8X428L0       |
--| 449774 | Taylor  | (286) 555-6063 | 1988161715      | 1106N58       |
--| 458378 | Brooke  | (122) 555-4581 | 4408372428      | QX4YZN3       |
--| 467400 | Luca    | (389) 555-5198 | 8496433585      | 4328GD8       |
--| 514354 | Diana   | (770) 555-1861 | 3592750733      | 322W7JE       |
--| 686048 | Bruce   | (367) 555-5533 | 5773159633      | 94KL13X       |
--+--------+---------+----------------+-----------------+---------------+

--Checking by license_plate
SELECT * FROM bakery_security_logs
WHERE day = 28 AND month = 7 and year = 2021 AND hour = 10 AND minute BETWEEN 15 AND 25 AND license_plate IN
    (SELECT license_plate FROM people
    WHERE id IN
        (SELECT person_id FROM bank_accounts
        WHERE account_number IN
            (SELECT account_number FROM atm_transactions
            WHERE atm_location = 'Leggett Street' AND day = 28 AND month = 7 AND year = 2021 AND transaction_type = 'withdraw')));

--+-----+------+-------+-----+------+--------+----------+---------------+
--| id  | year | month | day | hour | minute | activity | license_plate |
--+-----+------+-------+-----+------+--------+----------+---------------+
--| 261 | 2021 | 7     | 28  | 10   | 18     | exit     | 94KL13X       |
--| 263 | 2021 | 7     | 28  | 10   | 19     | exit     | 4328GD8       |
--| 265 | 2021 | 7     | 28  | 10   | 21     | exit     | L93JTIZ       |
--| 266 | 2021 | 7     | 28  | 10   | 23     | exit     | 322W7JE       |
--+-----+------+-------+-----+------+--------+----------+---------------+

-- People by filtered license_plate
SELECT * FROM people WHERE license_plate in ('94KL13X', '4328GD8', 'L93JTIZ', '322W7JE');
--+--------+-------+----------------+-----------------+---------------+
--|   id   | name  |  phone_number  | passport_number | license_plate |
--+--------+-------+----------------+-----------------+---------------+
--| 396669 | Iman  | (829) 555-5269 | 7049073643      | L93JTIZ       |
--| 467400 | Luca  | (389) 555-5198 | 8496433585      | 4328GD8       |
--| 514354 | Diana | (770) 555-1861 | 3592750733      | 322W7JE       |
--| 686048 | Bruce | (367) 555-5533 | 5773159633      | 94KL13X       |
--+--------+-------+----------------+-----------------+---------------+

-- Compare phonenumbers

SELECT * FROM people WHERE license_plate IN ('94KL13X', '4328GD8', 'L93JTIZ', '322W7JE') AND phone_number IN
(SELECT caller FROM phone_calls
WHERE day = 28 AND month = 7 AND year = 2021 and duration <= 60 );
--+--------+-------+----------------+-----------------+---------------+
--|   id   | name  |  phone_number  | passport_number | license_plate |
--+--------+-------+----------------+-----------------+---------------+
--| 514354 | Diana | (770) 555-1861 | 3592750733      | 322W7JE       |
--| 686048 | Bruce | (367) 555-5533 | 5773159633      | 94KL13X       |
--+--------+-------+----------------+-----------------+---------------+



--Checking the destination

--Flight ID's
SELECT * FROM passengers
WHERE passport_number = 3592750733 OR passport_number = 5773159633 ORDER BY passport_number;

--+-----------+-----------------+------+
--| flight_id | passport_number | seat |
--+-----------+-----------------+------+
--| 18        | 3592750733      | 4C   |
--| 24        | 3592750733      | 2C   |
--| 54        | 3592750733      | 6C   |
--| 36        | 5773159633      | 4A   |
--+-----------+-----------------+------+

--Checking the flight on theft's date
SELECT * FROM flights f
JOIN passengers p ON f.id = p.flight_id
WHERE day = 29 AND month = 7 AND year = 2021
AND passport_number = 3592750733 OR passport_number = 5773159633;

--+----+-------------------+------------------------+------+-------+-----+------+--------+-----------+-----------------+------+
--| id | origin_airport_id | destination_airport_id | year | month | day | hour | minute | flight_id | passport_number | seat |
--+----+-------------------+------------------------+------+-------+-----+------+--------+-----------+-----------------+------+
--| 18 | 8                 | 6                      | 2021 | 7     | 29  | 16   | 0      | 18        | 3592750733      | 4C   |
--| 36 | 8                 | 4                      | 2021 | 7     | 29  | 8    | 20     | 36        | 5773159633      | 4A   |
--+----+-------------------+------------------------+------+-------+-----+------+--------+-----------+-----------------+------+
-- Bruce is the thief, took the flight early on that day.

--Receiver
-- by checking the receiver through Bruce's number:
SELECT * FROM people WHERE phone_number = '(375) 555-8161';
--+--------+-------+----------------+-----------------+---------------+
--|   id   | name  |  phone_number  | passport_number | license_plate |
--+--------+-------+----------------+-----------------+---------------+
--| 864400 | Robin | (375) 555-8161 |                 | 4V16VO0       |
--+--------+-------+----------------+-----------------+---------------+


-- Checking the destination name
SELECT * FROM airports WHERE id = 4;
--+----+--------------+-------------------+---------------+
--| id | abbreviation |     full_name     |     city      |
--+----+--------------+-------------------+---------------+
--| 4  | LGA          | LaGuardia Airport | New York City |
--+----+--------------+-------------------+---------------+