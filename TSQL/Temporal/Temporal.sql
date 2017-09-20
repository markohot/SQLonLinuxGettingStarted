--Demo of AS OF FUNCTIONALITY

DECLARE @d DATETIME = GETDATE()

SELECT c.CityName ,
       s.StateProvinceName ,
       c.LatestRecordedPopulation
FROM   [Application].[Cities]
    FOR SYSTEM_TIME AS OF @d c
       INNER JOIN Application.StateProvinces s ON c.StateProvinceID = s.StateProvinceID
	   ORDER BY c.LatestRecordedPopulation DESC


--Demo of BETWEEN FUNCTIONALITY

SELECT c.CityName ,
       s.StateProvinceName ,
       c.LatestRecordedPopulation
FROM   [Application].[Cities]
    FOR SYSTEM_TIME BETWEEN '2013-01-01' AND '2014-07-02' c
       INNER JOIN Application.StateProvinces s ON c.StateProvinceID = s.StateProvinceID
	   ORDER BY c.LatestRecordedPopulation DESC

--Demo of ALL FUNCTIONALITY

SELECT c.CityName ,
       s.StateProvinceName ,
       c.LatestRecordedPopulation
FROM   [Application].[Cities]
    FOR SYSTEM_TIME ALL c
       INNER JOIN Application.StateProvinces s ON c.StateProvinceID = s.StateProvinceID
	   ORDER BY c.LatestRecordedPopulation DESC