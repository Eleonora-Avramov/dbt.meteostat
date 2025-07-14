WITH daily_data AS (
    SELECT * 
    FROM {{ref('staging_weather_daily')}}
),
add_features AS (
    SELECT *
		,DATE_PART('day', date) AS date_day 		-- number of the day of month
		,DATE_PART('month', date) AS date_month 	-- number of the month of year
		,DATE_PART('year', date) AS date_year 		-- number of year
		,DATE_PART('week', date) AS cw 			-- number of the week of year
		,TO_CHAR(date, 'FMMonth') AS month_name 	-- name of the month
		,TO_CHAR(date, 'FMDay') AS weekday 		-- name of the weekday
    FROM staging_weather_daily
),
add_more_features AS (
    SELECT *
, (CASE 
			WHEN month_name IN ('November', 'December', 'January') THEN 'winter'
            WHEN month_name IN ('February', 'March', 'May') THEN 'spring'
            WHEN month_name IN ('April', 'June', 'July') THEN 'summer'
            WHEN month_name IN ('August', 'September', 'October') THEN 'autumn'
		END) AS season
    FROM daily_data
)
SELECT *
FROM add_more_features
ORDER BY date