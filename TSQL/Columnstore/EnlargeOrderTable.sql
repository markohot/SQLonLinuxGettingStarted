--Credit to Koen Verbeeck for this script
--http://www.sqlservercentral.com/blogs/koen-verbeeck/2016/08/12/bigger-fact-table-for-wide-world-importers/
--This will take several minutes to execute
--Ensure that you have approximately 20 GB of space available 

USE [WideWorldImportersDW]

SELECT
	 [Order Key] = ISNULL(ROW_NUMBER() OVER(ORDER BY (SELECT NULL)),-1)
	,[City Key]
	,[Customer Key]
	,[Stock Item Key]
	,[Order Date Key]
	,[Picked Date Key]
	,[Salesperson Key]
	,[Picker Key]
	,[WWI Order ID]
	,[WWI Backorder ID]
	,[Description]
	,[Package]
	,[Quantity]
	,[Unit Price]
	,[Tax Rate]
	,[Total Excluding Tax]
	,[Tax Amount]
	,[Total Including Tax]
	,[Lineage Key]
INTO [Fact].[Order_Big_CCI]
FROM [Fact].[Order]
CROSS JOIN
(SELECT * FROM SYS.columns WHERE object_id < 50) tmp
