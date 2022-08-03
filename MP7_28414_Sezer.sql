
use dl7; # CREATED A schema named dl7

#Q1)
#Latest month from 2020-05-10 
SELECT FNAME, LNAME
FROM member, book_history
WHERE book_history.MEMBER_Number = member.MEMBER_Number AND MONTH(`CHECKOUT-DATE`) = 5 AND
book_history.MEMBER_Number IN (SELECT MEMBER_Number FROM book_history GROUP BY MEMBER_Number HAVING COUNT(CHECKOUT_Number) >=2 )
GROUP BY book_history.MEMBER_Number
;


#Q2) 
#Latest month from 2020-05-11 
SELECT FNAME, LNAME, SUM(book_history.PENALTY_FEE) AS FEE
FROM member, book_history
WHERE member.MEMBER_NUMBER = book_history.member_number AND book_history.IS_RETURN_LATE = "True" AND MONTH(`RETURN-DATE`) = 5 
GROUP BY FNAME
ORDER BY FEE DESC
LIMIT 1;



#Q3)
SELECT book.ISBN, COUNT(book_history.ISBN) AS Popularity, TITLE
FROM book_history, book
WHERE book_history.ISBN = book.ISBN
GROUP BY ISBN
ORDER BY Popularity DESC 
LIMIT 2;

#Q4)
SELECT TITLE AS BOOK_TITLE, AUTHOR AS AUTHORS
FROM book_author, book
WHERE book.ISBN = book_author.ISBN AND 
book.ISBN IN (SELECT book_author.ISBN FROM book_author GROUP BY book_author.ISBN HAVING count(book_author.ISBN) >=2);

#Q5) 
#Latest month from 2020-05-11 and summing the late fees ass revenue
SELECT SUM(PENALTY_FEE) AS "TOTAL REVENUE"
FROM book_history
WHERE  datediff(cast('2020-05-11 00:00:00' as date), `RETURN-DATE`) < 7;


#Q6)
SELECT TITLE, book.ISBN
FROM book, put_hold
WHERE book.ISBN NOT IN (SELECT ISBN FROM put_hold)
GROUP BY TITLE
ORDER BY TITLE DESC;

#Q7)  I assumed that the late penalty is 5 per day. 
SELECT TITLE, PENALTY_FEE/5 AS LATE_DAYS
FROM book_history, book
WHERE book_history.ISBN = book.ISBN AND IS_RETURN_LATE = 'TRUE'
ORDER BY TITLE ASC;




#Q8)
SELECT book.ISBN, TITLE
FROM book_availability, book
WHERE DATE = '2020-06-05 00:00:00'
AND book_availability.`AVAILABLE-COPY-NUMBER` = 0 AND book.ISBN = book_availability.ISBN
GROUP BY ISBN;


#Q9)
SELECT FNAME, LNAME 
FROM member, put_hold
WHERE member.MEMBER_NUMBER = put_hold.MEMBER_NUMBER
AND put_hold.MEMBER_NUMBER IN (SELECT MEMBER_NUMBER FROM PUT_HOLD GROUP BY MEMBER_NUMBER HAVING count(ISBN) >= 2)
GROUP BY member.MEMBER_NUMBER;

#Q10)
SELECT PUBLISHER
FROM book
WHERE book.ISBN IN (SELECT ISBN FROM book GROUP BY PUBLISHER HAVING count(ISBN) >2);


