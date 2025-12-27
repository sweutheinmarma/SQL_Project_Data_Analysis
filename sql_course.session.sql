WITH remote_job_skills AS 
(SELECT
    sjd.skill_id,
    COUNT (*) AS job_count
FROM
    job_postings_fact AS jpf
INNER JOIN
    skills_job_dim AS sjd ON jpf.job_id=sjd.job_id
WHERE
    job_work_from_home IS TRUE
GROUP BY    
    skill_id)
SELECT
    skill_id,
    sd.skills,
    rjs.job_count
FROM
    skills_dim AS sd
INNER JOIN
    remote_job_skills AS rjs ON sd.skill_id=rjs.skill_id

