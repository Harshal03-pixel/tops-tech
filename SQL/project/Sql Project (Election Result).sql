create database Election_result;
use Election_result;

CREATE TABLE election_results (
Constituency varchar(255),
Const_No int,
Leading_Candidate varchar(255),
Leading_Party varchar(255),
Trailing_Candidate varchar(255),
Trailing_Party varchar(255),
Margin varchar(25),
Statuss varchar(50)
);

SHOW VARIABLES LIKE "secure_file_priv";
SET GLOBAL local_infile = 1;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/election_results_2024 (2).csv'
INTO TABLE election_results
FIELDS TERMINATED BY ','  
ENCLOSED BY '"'  
LINES TERMINATED BY '\n'  
IGNORE 1 ROWS;

-- 1. Count of seats won by each party
select Leading_Party, COUNT(*) AS seats_won
from election_results
group by  Leading_Party
order by seats_won DESC;

-- 2. Constituencies with the highest victory margins
select Constituency, Leading_Candidate, Leading_Party, Margin
from election_results
order by Margin DESC
limit 10;

-- 3. Closest contests (smallest victory margins)
select Constituency, Leading_Candidate, Leading_Party, Trailing_Candidate, Trailing_Party, Margin
FROM election_results
order by Margin ASC
LIMIT 10;


-- 4. Average victory margin per party
SELECT Leading_Party, AVG(Margin) AS avg_margin
FROM election_results
GROUP BY Leading_Party
ORDER BY avg_margin DESC;

-- 5. Performance of major parties (BJP & Congress example)
SELECT Leading_Party, COUNT(*) AS seats_won, AVG(Margin) AS avg_margin
FROM election_results
WHERE Leading_Party IN ('Bharatiya Janata Party', 'Indian National Congress')
GROUP BY Leading_Party;

-- 6. Total votes difference between leading and trailing candidates per constituency
SELECT Constituency, Leading_Candidate, Trailing_Candidate, Margin
FROM election_results
ORDER BY Margin DESC;


-- 7. Number of constituencies contested by each party (both leading and trailing)
SELECT Leading_Party, Trailing_Party,COUNT(*) AS contested_seats
FROM election_results
GROUP BY Leading_Party,Trailing_Party
ORDER BY contested_seats DESC;


-- 8. Constituencies where margin was greater than 1 lakh votes
SELECT Constituency, Leading_Candidate, Leading_Party,Margin
FROM election_results
WHERE Margin > 100000
ORDER BY Margin DESC
limit 10;


-- 9. Constituencies where margin was less than 5000 votes
SELECT Constituency,Leading_Candidate,Leading_Party,Margin
FROM election_results
WHERE Margin < 5000
ORDER BY Margin ASC
limit 10;


-- 10. Number of constituencies where a party finished second as runner-up count
SELECT Trailing_Party, COUNT(*) AS runner_up_count
FROM election_results
GROUP BY Trailing_Party
ORDER BY runner_up_count DESC;


-- **************************************************************************************************************
-- INSIGHTS
-- **************************************************************************************************************
 -- Key Insights from Election Results 2024  

-- 1 Winning Candidate with Highest Vote Margin  
   -- **Bhagirath Choudhary** (BJP, Ajmer) won by **329,991 votes**.  
   -- Indicates strong voter support in this region.  

-- 2 Parties with Most Wins  
   -- **Bharatiya Janata Party (BJP)** won the most constituencies.  
   -- **Indian National Congress (INC)** followed as the second-most successful party.  

-- 3 Closest Contest (Smallest Vote Margin)  
   -- **Lalit Yadav (INC) vs. Bhupender Yadav (BJP) in Alwar** with just **48,282 votes**.  
   -- Suggests a highly competitive battle in this constituency.  

-- 4 State-Wise Dominance  
   -- **Jammu & Kashmir National Conference** won **Anantnag-Rajouri**, showing regional stronghold.  
   -- **Dravida Munnetra Kazhagam (DMK)** dominated in Tamil Nadu.  

-- 5 Impact of Regional Parties  
   -- **Jammu & Kashmir People's Democratic Party (JKPDP)** and **AIADMK** performed well in their respective regions.  
   -- Highlights the importance of regional politics in India.  

-- 6️ Seats Won by National vs. Regional Parties  
   -- National parties (BJP, INC) secured majority seats.  
   -- Regional parties still have strong influence in key states. 




