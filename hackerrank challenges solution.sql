select h.hacker_id,h.name,COUNT(c.challenge_id) as challenge_cnt
from Hackers h (nolock)
INNER JOIN Challenges c (nolock)
ON h.hacker_id = c.hacker_id
GROUP BY h.hacker_id,h.name
HAVING 
COUNT(c.challenge_id)
IN
(
    select MAX(challenge_cnt)
    FROM
    (select h.hacker_id,h.name,COUNT(c.challenge_id) as challenge_cnt
    from Hackers h (nolock)
    INNER JOIN Challenges c (nolock)
    ON h.hacker_id = c.hacker_id
    GROUP BY h.hacker_id,h.name) a
)
OR COUNT(c.challenge_id)
IN
(
    select challenge_cnt
    FROM
    (select h.hacker_id,h.name,COUNT(c.challenge_id) as challenge_cnt
    from Hackers h (nolock)
    INNER JOIN Challenges c (nolock)
    ON h.hacker_id = c.hacker_id
    GROUP BY h.hacker_id,h.name) b
    GROUP BY challenge_cnt
    HAVING COUNT(challenge_cnt) = 1
)
ORDER BY COUNT(c.challenge_id) DESC, hacker_id
