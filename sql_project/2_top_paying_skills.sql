/* What skills are required for the top-paying data analyst jobs?
- Use the top 10 highest-paying Data Analyst jobs from first query
- Add the specific skills required for these roles
- Why? It provides a detailed look at which high-paying jobs demand certain skills,
helping job seekers understand which skills to develop that align with top salaries.
*/


WITH top_paying AS (
    SELECT
        job_id, job_title, name AS company_name,
        job_location,
        COALESCE(salary_year_avg, salary_hour_avg * 40 * 52) AS avg_salary
    FROM
        job_postings_fact jpf
    LEFT JOIN company_dim cd ON cd.company_id = jpf.company_id
    WHERE
        job_title_short = 'Data Analyst' AND
        (
        job_location LIKE '%BC%' OR
        job_location LIKE '%British Columnbia%' OR
        job_location = 'Anywhere'
        )
        AND COALESCE(salary_year_avg, salary_hour_avg * 40 * 52) IS NOT NULL
    ORDER BY avg_salary DESC 
    LIMIT 10
)

SELECT top_paying.*, skills
FROM top_paying
INNER JOIN skills_job_dim sjd ON sjd.job_id = top_paying.job_id
INNER JOIN skills_dim sd ON sd.skill_id = sjd.skill_id
ORDER BY avg_salary DESC;