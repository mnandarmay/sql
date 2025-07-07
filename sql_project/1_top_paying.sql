/* What are the top-paying data analyst jobs?
- Identify the top 20 highest-paying data analyst roles that are available remotely
- Focus on job postings with specified salaries (remove nulls)
- Why? Highlights the top-paying opportunities for Data Analyst, offering insights into employment opportunities & location flexibility
*/

SELECT
    job_id, job_title, name AS company_name,
    job_location,
    job_schedule_type,
    job_posted_date,
    COALESCE(salary_year_avg, salary_hour_avg * 40 * 52) AS avg_salary,
    job_posted_date::DATE
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
LIMIT 20;

