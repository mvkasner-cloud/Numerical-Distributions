--use Mariia

/*
select *
from [dbo].[NumericalDistributions];
*/

/*
;ALTER TABLE [dbo].[NumericalDistributions]
DROP COLUMN F2, F3, F4, F5;
*/

WITH Ranges AS (
    SELECT 
        FLOOR(([Annual Salary (Thousands of USD)] - 10) / 20.0) * 20 + 10 AS RangeStart
    FROM dbo.NumericalDistributions
),
Grouped AS (
    SELECT 
        CAST(RangeStart AS VARCHAR) + '–' + CAST(RangeStart + 20 AS VARCHAR) AS SalaryRange,
        COUNT(*) AS Frequency,
        RangeStart
    FROM Ranges
    GROUP BY RangeStart
),
Filtered AS (
    SELECT *
    FROM Grouped
    WHERE RangeStart >= 70 AND RangeStart <= 330
),
WithCumulative AS (
    SELECT
        SalaryRange,
        Frequency,
        RangeStart,
        SUM(Frequency) OVER (ORDER BY RangeStart) AS CumulativeFreq,
        SUM(Frequency) OVER () AS TotalFreq
    FROM Filtered
)
SELECT
    SalaryRange AS [Annual Salary Range],
    Frequency,
    CAST(100.0 * CumulativeFreq / TotalFreq AS DECIMAL(5,2)) AS [Cumulative Relative Frequency, %]
FROM WithCumulative
ORDER BY RangeStart;
