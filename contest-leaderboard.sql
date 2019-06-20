select s.hacker_id,h.name,SUM(s.max_score) as total_score
from
(
select hacker_id,challenge_id,MAX(score) as max_score
from Submissions (nolock)
GROUP BY hacker_id,challenge_id
) s
INNER JOIN
Hackers h (nolock)
ON s.hacker_id = h.hacker_id
WHERE s.max_score <> 0
GROUP BY s.hacker_id,h.name
ORDER BY 3 DESC, 1 ASC
