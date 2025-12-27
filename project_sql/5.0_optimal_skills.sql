WITH skills_demand AS
    (SELECT
        skills_dim.skill_id,
        skills_dim.skills,
        COUNT(job_postings_fact.job_id) as demand_count
    FROM
        job_postings_fact
    INNER JOIN skills_job_dim ON skills_job_dim.job_id=job_postings_fact.job_id
    INNER JOIN skills_dim ON skills_dim.skill_id=skills_job_dim.skill_id
    WHERE
        job_title_short= 'Data Analyst' AND
        job_work_from_home IS TRUE AND
        salary_year_avg IS NOT NULL
    GROUP BY
        skills_dim.skill_id),
average_salary AS
    (SELECT
        skills_dim.skill_id,
        ROUND(AVG(salary_year_avg),2) AS yearly_salary
    FROM
        job_postings_fact
    INNER JOIN skills_job_dim ON skills_job_dim.job_id=job_postings_fact.job_id
    INNER JOIN skills_dim ON skills_dim.skill_id=skills_job_dim.skill_id
    WHERE
        job_title_short= 'Data Analyst' AND
        job_work_from_home IS TRUE AND
        salary_year_avg IS NOT NULL
    GROUP BY
        skills_dim.skill_id)
SELECT
    skills_demand.skill_id,
    skills_demand.skills,
    demand_count,
    yearly_salary
FROM
    skills_demand
INNER JOIN
    average_salary ON average_salary.skill_id=skills_demand.skill_id
WHERE
    demand_count>10
ORDER BY
    yearly_salary DESC,
    demand_count DESC
LIMIT
    25;