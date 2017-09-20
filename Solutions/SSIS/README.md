# ETL Process for WideWorldImporters

This SSIS project performs ETL from the transactional database WideWorldImporters into the OLAP database WideWorldImportersDW for long-term storage and analytics.

### Contents

[About this sample](#about-this-sample)<br/>
[Before you begin](#before-you-begin)<br/>
[Running the sample](#run-this-sample)<br/>
[Sample details](#sample-details)<br/>
[Disclaimers](#disclaimers)<br/>
[Related links](#related-links)<br/>


<a name=about-this-sample></a>

## About this sample

<!-- Delete the ones that don't apply -->
1. **Applies to:** SQL Server 2016 (or higher)
1. **Key features:** Core database features
1. **Workload:** ETL
1. **Programming Language:**
1. **Authors:** Greg Low, Denzil Ribeiro, Jos de Bruijn
1. **Update history:** 25 May 2016 - initial revision

<a name=before-you-begin></a>

## Before you begin

To run this sample, you need the following prerequisites.

**Software prerequisites:**

1. The databases WideWorldImporters and WideWorldImportersDW running on SQL Server 2016 (or higher) or Azure SQL Database. These can be on different servers.
2. Visual Studio 2015 Update 3 (or higher). At the time of writing, Visual Studio 2017 does not yet support Integration Services projects. You will need to install Visual Studio 2015 to open the SSIS project.
3. SSIS Running on Linux

<a name=run-this-sample></a>

## Running the sample

1. Open the solution file wwi-ssis.sln in Visual Studio.

2. From Solution Explorer open the SSIS Packages Folder
    1. Double click DailyETLMain.dtsx
    1. Double click on each connection, and enter the name or IP Address of your server and then the password for your SA account
    1. Right click on DailyETL and select build. 
    1. From the folder where you opened wwi-ssis.sln click the wwi-ssis folder.
    1. Launch an SFTP utility and copy DailyETLMain.dtsx to your Linux folder

3. Execute the SSIS package.
    1. Ensure that your user is part of the SSIS group by running the following commnd "sudo usermod -a -G ssis $username"
    1. You will need to replace $username with your username
    1. You will need to logout to get a new token
    1. Run the package with the following command:  /opt/ssis/bin/dtexec /F DailyETLMain.dtsx  /DE P@ssw0rd!


## Sample details

The ETL package **Daily ETL.ispac** is used to migrate data from the WideWorldImporters database to the WideWorldImportersDW database as the data changes. The package is run periodically (most commonly daily).

The design of the package uses SSIS to orchestrate bulk T-SQL operations (rather than as separate transformations within SSIS) to ensure high performance.

Dimensions are loaded first, followed by Fact tables. The package can be re-run at any time after a failure.

The workflow is as follows:

![Alt text](/media/wide-world-importers-etl-workflow.png "WideWorldImporters ETL Workflow")

It starts with an expression task that works out the appropriate cutoff time. This time is the current time less a few seconds. (This is more robust than requesting data right to the current time). It then truncates any milliseconds from the time.

The main processing starts by populating the Date dimension table. It ensures that all dates for the current year have been populated in the table.

After this, a series of data flow tasks loads each dimension, then each fact.


<a name=disclaimers></a>

## Disclaimers
The code included in this sample is not intended to be used for production purposes.

<a name=related-links></a>

## Related Links
For more information, see these articles:
- [SQL Server Integration Services documentation](https://msdn.microsoft.com/library/ms141026.aspx)
