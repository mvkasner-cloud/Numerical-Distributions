--use Mariia

/*
select *
from [dbo].[NumericalDistributions];
*/

/*
;ALTER TABLE [dbo].[NumericalDistributions]
DROP COLUMN F2, F3, F4, F5;
*/


DECLARE @Step INT = 20;  -- Interval step size (e.g., 10, 20, 50)

-- Create salary bins by rounding down to the nearest interval
WITH SalaryBins AS (
    SELECT 
        RangeStart = FLOOR(([Annual Salary (Thousands of USD)] - 10) / @Step) * @Step + 10
    FROM dbo.NumericalDistributions
),

-- Count the frequency of values in each bin
Grouped AS (
    SELECT 
        SalaryRange = CONCAT(RangeStart, '–', RangeStart + @Step),
        RangeStart,
        Frequency = COUNT(*)
    FROM SalaryBins
    GROUP BY RangeStart
),

-- Calculate cumulative frequency and total frequency
WithCumulative AS (
    SELECT
        SalaryRange,
        Frequency,
        RangeStart,
        CumulativeFreq = SUM(Frequency) OVER (ORDER BY RangeStart),
        TotalFreq = SUM(Frequency) OVER ()
    FROM Grouped
)

-- Final output with relative and cumulative relative frequencies
SELECT
    SalaryRange AS [Annual Salary Range],
    Frequency,
    CAST(100.0 * Frequency / TotalFreq AS DECIMAL(6,2)) AS [RelFreq, %],
    CAST(100.0 * CumulativeFreq / TotalFreq AS DECIMAL(6,2)) AS [CumRelFreq, %]
FROM WithCumulative
ORDER BY RangeStart;


