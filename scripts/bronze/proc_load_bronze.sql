/*
============================================================
Stored Procedure: Load Bronze Layer (Source -> Bronze)
============================================================
Script Purpose: 
    This stored procedure loads data into the 'bronze' schema from external CSV files.
    It performs the following actions:
    - Truncates the bronze tables before loading data.
    - Uses the 'BULK INSERT' command to load data from csv files to bronze tables.

Parameters:
    None
    This sctored procedure does not accept any parameters or return any values.

Usage Example: 
    EXEC load.bronze_bronze;
*/

USE [DataWarehouse]
GO
/****** Object:  StoredProcedure [bronze].[load_bronze]    Script Date: 30/07/2025 9:49:26 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER   PROCEDURE [bronze].[load_bronze] AS
BEGIN
	DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME;
	BEGIN TRY
		SET @batch_start_time = GETDATE();
		PRINT '======================================================';
		PRINT 'LOADING BRONZE LAYER'
		PRINT '======================================================';

		PRINT '------------------------------------------------------';
		PRINT 'Loading CRM Tables'
		PRINT '------------------------------------------------------';

		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: bronze.crm_cust_info'
		TRUNCATE TABLE bronze.crm_cust_info;

		PRINT '>> Inserting Data Into: bronze.crm_cust_info'
		BULK INSERT bronze.crm_cust_info
		FROM 'C:\Users\Aaron\Documents\Coding\Data_Engineering\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '>> ---------------------------';
		PRINT '                              ';
		-- SELECT * FROM bronze.crm_cust_info

		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: bronze.crm_prd_info'
		TRUNCATE TABLE bronze.crm_prd_info;

		PRINT '>> Inserting Data Into: bronze.crm_prd_info'
		BULK INSERT bronze.crm_prd_info
		FROM 'C:\Users\Aaron\Documents\Coding\Data_Engineering\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '>> ---------------------------';
		PRINT '                              ';
		-- SELECT * FROM bronze.crm_prd_info

		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: bronze.crm_sales_details'
		TRUNCATE TABLE bronze.crm_sales_details;

		PRINT '>> Inserting Data Into: bronze.crm_sales_details'
		BULK INSERT bronze.crm_sales_details
		FROM 'C:\Users\Aaron\Documents\Coding\Data_Engineering\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '>> ---------------------------';
		PRINT '                              ';

		-- SELECT * FROM bronze.crm_sales_details

		------------------------------------------------------------------------------

		PRINT '------------------------------------------------------';
		PRINT 'Loading ERP Tables'
		PRINT '------------------------------------------------------';

		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: bronze.erp_cust_AZ12'
		TRUNCATE TABLE bronze.erp_cust_AZ12;

		PRINT '>> Inserting Data Into: bronze.erp_cust_AZ12'
		BULK INSERT bronze.erp_cust_AZ12
		FROM 'C:\Users\Aaron\Documents\Coding\Data_Engineering\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '>> ---------------------------';
		PRINT '                              ';
		-- SELECT * FROM bronze.erp_cust_AZ12

		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: bronze.erp_loc_a101'
		TRUNCATE TABLE bronze.erp_loc_a101;

		PRINT '>> Inserting Data Into: bronze.erp_loc_a101'
		BULK INSERT bronze.erp_loc_a101
		FROM 'C:\Users\Aaron\Documents\Coding\Data_Engineering\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '>> ---------------------------';
		PRINT '                              ';
		-- SELECT * FROM bronze.erp_loc_a101

		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: erp_px_cat_g1v2'
		TRUNCATE TABLE bronze.erp_px_cat_g1v2;

		PRINT '>> Inserting Data Into: erp_px_cat_g1v2'
		BULK INSERT bronze.erp_px_cat_g1v2
		FROM 'C:\Users\Aaron\Documents\Coding\Data_Engineering\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '>> ---------------------------';
		PRINT '                              ';

		-- SELECT * FROM bronze.erp_px_cat_g1v2
		SET @batch_end_time = GETDATE();
		PRINT '==========================================';
		PRINT 'Loading Bronze Layer is Completed';
		PRINT '>> Total Load Duration: ' + CAST(DATEDIFF(second, @batch_start_time, @batch_end_time) AS NVARCHAR) + ' seconds';
		PRINT '==========================================';
	END TRY
	BEGIN CATCH
		PRINT '==========================================';
		PRINT 'Error Occured During Loading Bronze Layer';
		PRINT 'Error Message' + ERROR_MESSAGE();
		PRINT 'Error Message' + CAST (ERROR_NUMBER() AS NVARCHAR);
		PRINT 'Error Message' + CAST (ERROR_STATE() AS NVARCHAR);
		PRINT '==========================================';
	END CATCH
END