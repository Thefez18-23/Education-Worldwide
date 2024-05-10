--This SQL command would return the names
--of the geographic areas, the time periods, 
--and the values (proportions) of females skilled in math.

/* What is the average proportion of females 
skilled in math across all countries?*/
---First Overview the Table

Select * From education_data;

SELECT AVG(Value) AS average_female_math_skill
FROM education_data
WHERE Sex = 'FEMALE' AND Type_of_skill = 'SKILL_MATH';

----Average proportion Females skilled in reading across all countries.
Select * From education_data;

SELECT AVG(Value) AS average_Female_read_skill
FROM education_data
WHERE Sex = 'FEMALE' AND Type_of_skill = 'SKILL_READ';



----Average proportion Males skilled in reading across all countries.

Select * From education_data;

SELECT AVG(Value) AS average_male_read_skill
FROM education_data
WHERE Sex = 'MALE' AND Type_of_skill = 'SKILL_READ';





/*This query calculates the average value of the proportion
of females skilled in math across all records in the 
database that meet the specified criteria.*/

--Average proportion Males skilled in math across alll countries.

Select * From education_data;

SELECT AVG(Value) AS average_male_math_skill
FROM education_data
WHERE Sex = 'MALE' AND Type_of_skill = 'SKILL_MATH';

----Using basic arithmetic formulas
Select * From education_data;

SELECT AVG(Value) AS average_male_arithmetic_skill
FROM education_data
WHERE Sex = 'MALE' AND Type_of_skill = 'ARSP';


----Transferring files between a computer and other devices.
Select * From education_data;

SELECT AVG(Value) AS average_male_computer_skill
FROM education_data
WHERE Sex = 'MALE' AND Type_of_skill = 'TRAF';


----Males CREATING PRESENTATIONS WITH A SOFTWARE

Select * From education_data;

SELECT AVG(Value) AS average_male_computer_skill
FROM education_data
WHERE Sex = 'MALE' AND Type_of_skill = 'EPRS';


----Copying or moving a file or folder

Select * From education_data;

SELECT AVG(Value) AS average_male_computer_skill
FROM education_data
WHERE Sex = 'MALE' AND Type_of_skill = 'CMFL';


---Using aritmethic formula in a spreadsheet.

Select * From education_data;

SELECT AVG(Value) AS average_male_computer_skill
FROM education_data
WHERE Sex = 'MALE' AND Type_of_skill = 'ARSP';


--Which country had the highest proportion of females skilled in math in the latest recorded year?

SELECT GeoAreaName, TimePeriod, MAX(Value) AS max_female_math_skill
FROM education_data
WHERE Sex = 'FEMALE' AND Type_of_skill = 'SKILL_MATH'
GROUP BY GeoAreaName, TimePeriod
ORDER BY TimePeriod DESC, max_female_math_skill DESC
LIMIT 1;

/*This query finds the country with the highest proportion of females skilled in math in the most recent year data is available. It orders the results by year and value, 
descending, and limits the result to the top record.*/


--How has the proportion of females skilled in math changed over time in a specific country, e.g., Nicaragua?

SELECT TimePeriod, Value AS female_math_skill
FROM education_data
WHERE GeoAreaName = 'Nicaragua' AND Sex = 'FEMALE' AND Type_of_skill = 'SKILL_MATH'
ORDER BY TimePeriod;

----How has the proportion of females skilled in math changed over time in a specific country, e.g., Nicaragua?


SELECT TimePeriod, Value AS male_math_skill
FROM education_data
WHERE GeoAreaName = 'Canada' AND Sex = 'MALE' AND Type_of_skill = 'SKILL_MATH'
ORDER BY TimePeriod;





---What is the proportion of females skilled in math in comparison to males in the most recent year globally?

SELECT Sex, AVG(Value) AS avg_skill
FROM education_data
WHERE Type_of_skill = 'SKILL_MATH' AND TimePeriod = (
    SELECT MAX(TimePeriod) FROM education_data WHERE Type_of_skill = 'SKILL_MATH'
)
GROUP BY Sex;

--This query compares the average proportion of math skill between males and females in the latest 
--year that data is available, grouped by sex.


--What are the top 5 countries with the highest
--average proportion of children achieving at least a 
--minimum proficiency level in reading at the primary level?


SELECT GeoAreaName, AVG(Value) AS avg_reading_skill
FROM education_data
WHERE Education_level = 'PRIMAR' AND Type_of_skill = 'SKILL_READ'
GROUP BY GeoAreaName
ORDER BY avg_reading_skill DESC
LIMIT 5;
--This query identifies the top 5 countries where children 
--have the highest average proficiency in reading at the primary level,
--showcasing areas with strong early education systems.

--How has the proportion of students achieving math 
--proficiency changed from primary to lower secondary 
--education in the Nicaragua?

SELECT Education_level, AVG(Value) AS avg_math_proficiency
FROM education_data
WHERE GeoAreaName = 'Nicaragua' AND Type_of_skill = 'SKILL_MATH'
GROUP BY Education_level
ORDER BY Education_level;

--This query provides insights into the progression 
--of math skills as students in Nicaragua 
--move from primary to lower secondary education.


 --Which countries have shown the most improvement in math 
 --skills at any education level over the last decade?

WITH RankedValues AS (
    SELECT GeoAreaName, TimePeriod, AVG(Value) OVER (PARTITION BY GeoAreaName, TimePeriod) AS avg_value
    FROM education_data
    WHERE Type_of_skill = 'SKILL_MATH' AND TimePeriod >= (SELECT MAX(TimePeriod) - 10 FROM education_data)
)
SELECT GeoAreaName, MAX(avg_value) - MIN(avg_value) AS improvement
FROM RankedValues
GROUP BY GeoAreaName
ORDER BY improvement DESC;
--This query ranks countries based on the improvement in their average math skill values 
--over the last decade, highlighting those with significant educational advancements.

--What percentage of bothsex students achieve proficiency
--in reading at the upper secondary level across different regions?
SELECT GeoAreaName, AVG(Value) AS avg_read_skill
FROM education_data
WHERE Education_level = 'LOWSEC' AND Type_of_skill = 'SKILL_READ' AND Sex = 'BOTHSEX'
GROUP BY GeoAreaName
ORDER BY avg_read_skill DESC;

--To analyze educational progression, we will compare the average proficiency
--levels from primary through upper secondary levels.

SELECT Education_level, GeoAreaName, AVG(Value) AS avg_proficiency
FROM education_data
WHERE Type_of_skill = 'SKILL_MATH' -- You can change this to SKILL_READ or SKILL_SCIENCE depending on the focus
GROUP BY Education_level, GeoAreaName
ORDER BY GeoAreaName, CASE WHEN Education_level = 'PRIMAR' THEN 1 WHEN Education_level = 'LOWSEC' THEN 2 WHEN Education_level = 'UPPSEC' THEN 3 ELSE 4 END;



--To compare educational achievements by region, we might want to segment data 
--by geographic areas and compare the proficiency in different subjects.



SELECT GeoAreaName, Type_of_skill, AVG(Value) AS avg_skill_proficiency
FROM education_data
WHERE TimePeriod = (SELECT MAX(TimePeriod) FROM education_data) -- focusing on the most recent data
GROUP BY GeoAreaName, Type_of_skill
ORDER BY GeoAreaName, Type_of_skill;



/*Analyzing the `edu_world` table from your dataset, we can discuss several aspects and possibilities for further exploration based on the columns and the data nature you've provided. Here are some insights and additional analyses that could be carried out:

### 1. **Data Diversity and Coverage**
   - **Geographic Distribution**: Check how many countries or regions are covered and whether the data represents global trends or is focused on specific areas.
   - **Time Span**: Determine the range of years available in the dataset. This can help understand trends over time and the relevance of the data to current educational standards.

### 2. **Quality and Completeness of Data**
   - **Null Values**: Analyze columns for missing data which may affect the reliability of any analysis performed.
   - **Consistency in Data Reporting**: Since this involves data potentially coming from different sources or methodologies, check for consistency in how data is reported, especially in columns like `Value`, `Education_level`, and `Type_of_skill`.

### 3. **Educational Levels and Skills**
   - **Breakdown by Education Level**: Explore how proficiency varies across different educational levels (primary, secondary, etc.) and its implications on education policies.
   - **Skill-specific Analysis**: Look at the data split by skill type (math, reading, science) to determine focus areas for improvement or strengths within educational systems.

### 4. **Demographic Insights**
   - **Gender Analysis**: The data includes gender-specific information, allowing for analysis of gender disparities in education across different regions and skills.
   - **Age-specific Trends**: If the age data is available and reliable, trends by age groups could reveal critical insights into when students achieve certain proficiency levels.

### 5. **Statistical Analysis Potential**
   - **Correlation Analysis**: Determine if there's a correlation between educational proficiency and other factors like geographic location, time, and economic status of the regions.
   - **Regression Analysis**: Use regression models to predict future trends based on historical data.

### 6. **Advanced Analytics**
   - **Machine Learning**: Apply machine learning techniques to predict future trends or to classify regions based on educational achievement.
   - **Time Series Analysis**: Since the data spans multiple years, time series analysis could be very useful to forecast future educational outcomes based on past trends.

### 7. **Policy Impact Evaluation**
   - **Impact of Educational Policies**: By analyzing data before and after the implementation of educational reforms, the impact of policies on proficiency levels across different skills and levels can be assessed.

### 8. **Visualizations**
   - **Graphical Representations**: Creating visualizations such as heatmaps, line graphs, or bar charts can help in better understanding and presenting the data, especially when looking at trends over time or comparisons between groups.

### 9. **International Comparisons**
   - **Benchmarking**: Compare data against international benchmarks or averages to evaluate where a country or region stands globally.*/


--International Comparisons
--To compare the educational proficiency across different countries for a specific skill, we might use an aggregate function like AVG to get the average proficiency score and then compare it.


SELECT GeoAreaName, AVG(Value) AS Average_Proficiency
FROM education_data
WHERE Type_of_skill = 'SKILL_MATH' -- This can be changed to any skill
GROUP BY GeoAreaName
ORDER BY Average_Proficiency DESC;

--While SQL isn't typically used for complex statistical analysis, I can still execute some 
--foundational statistical operations like standard deviation, variance, and simple linear trends using SQL functions.



SELECT GeoAreaName,
       STDDEV(Value) AS Standard_Deviation,
       VARIANCE(Value) AS Variance
FROM education_data
WHERE Type_of_skill = 'SKILL_MATH' AND GeoAreaName = 'Nicaragua'
GROUP BY GeoAreaName;


--This query estimates a simple linear trend by using a linear 
--regression approach over the years for which data is available.

SELECT GeoAreaName,
       (COUNT(*) * SUM(TimePeriod * Value) - SUM(TimePeriod) * SUM(Value)) /
       (COUNT(*) * SUM(TimePeriod * TimePeriod) - SUM(TimePeriod) * SUM(TimePeriod)) AS Slope
FROM education_data
WHERE Type_of_skill = 'SKILL_MATH' AND GeoAreaName = 'Nicaragua'
GROUP BY GeoAreaName;

--SQL Query to Identify Countries with High Education Proficiency



SELECT GeoAreaName, Education_level, AVG(Value) AS Average_Proficiency
FROM education_data
WHERE Education_level IN ('UPPSEC', 'TERTIARY') -- Adjust based on available levels in your data
GROUP BY GeoAreaName, Education_level
ORDER BY Average_Proficiency DESC;




SELECT GeoAreaName, AVG(Value) AS Average_Math_Proficiency
FROM education_data
WHERE Education_level = 'LOWSEC' AND Type_of_skill = 'SKILL_MATH'
GROUP BY GeoAreaName
ORDER BY Average_Math_Proficiency DESC
LIMIT 5;


--SQL Query to Find the Year with the Lowest Average Educational Proficiency
SELECT TimePeriod, AVG(Value) AS Average_Proficiency
FROM education_data
GROUP BY TimePeriod
ORDER BY Average_Proficiency ASC
LIMIT 1;

--SQL Query to Identify the Country with the Highest Proficiency in Higher Education

SELECT GeoAreaName, AVG(Value) AS Average_Proficiency
FROM education_data
WHERE Education_level IN ('UPPSEC', 'TERTIARY') -- Assuming 'TERTIARY' data is available; adjust as necessary
GROUP BY GeoAreaName
ORDER BY Average_Proficiency DESC
LIMIT 1;

--Query for Lowest Proficiency Scores:


SELECT GeoAreaName, AVG(Value) AS Average_Proficiency
FROM education_data
GROUP BY GeoAreaName
ORDER BY Average_Proficiency ASC
LIMIT 5;




--SQL Query for Gender Disparity:



SELECT GeoAreaName, 
       AVG(Value) FILTER (WHERE Sex = 'FEMALE') AS Female_Proficiency,
       AVG(Value) FILTER (WHERE Sex = 'MALE') AS Male_Proficiency,
       ABS(AVG(Value) FILTER (WHERE Sex = 'FEMALE') - AVG(Value) FILTER (WHERE Sex = 'MALE')) AS Disparity
FROM education_data
GROUP BY GeoAreaName
ORDER BY Disparity DESC
LIMIT 5;



SELECT 
    GeoAreaName,
    TimePeriod,
    COALESCE(Sex, 'Unknown') AS Sex, -- Still handling missing values
    COALESCE(Education_level, 'Unknown') AS Education_level,
    AVG(Value) AS Average_Value
FROM 
    education_data
WHERE 
    Sex IS NOT NULL AND Sex <> 'Unknown' AND education_level <>'Unknown' -- Exclude rows where Sex is 'Unknown'
GROUP BY 
    GeoAreaName, 
    TimePeriod, 
    Sex, 
    Education_level
ORDER BY 
    GeoAreaName, 
    TimePeriod, 
    Sex, 
    Education_level;


SELECT 
    GeoAreaName,
    TimePeriod,
    COALESCE(Sex, 'Unknown') AS Sex, -- Handling missing values by setting them to 'Unknown'
    COALESCE(Education_level, 'Unknown') AS Education_level,
    AVG(Value) AS Average_Value
FROM 
    education_data
WHERE 
    Sex = 'MALE' AND  -- Include only rows where Sex is 'MALE'
    Education_level <> 'Unknown' AND -- Exclude rows where Education_level is 'Unknown'
    GeoAreaName = 'Nicaragua'
GROUP BY 
    GeoAreaName, 
    TimePeriod, 
    Sex, 
    Education_level
ORDER BY 
    GeoAreaName, 
    TimePeriod, 
    Sex, 
    Education_level;

SELECT 
    GeoAreaName,
    TimePeriod,
    COALESCE(Sex, 'Unknown') AS Sex, -- Handling missing values by setting them to 'Unknown'
    COALESCE(Education_level, 'Unknown') AS Education_level,
    AVG(Value) AS Average_Value
FROM 
    education_data
WHERE 
    Sex = 'MALE' AND  -- Include only rows where Sex is 'MALE'
    Education_level <> 'Unknown' AND -- Exclude rows where Education_level is 'Unknown'
    GeoAreaName = 'Nicaragua'
GROUP BY 
    GeoAreaName, 
    TimePeriod, 
    Sex, 
    Education_level
ORDER BY 
    GeoAreaName, 
    TimePeriod, 
    Sex, 
    Education_level;