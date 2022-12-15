# yelp_dataset
Getting started with the Yelp Dataset JSON files, and performing some first analytis

## technologies used
- python3
- jupyter notebook
- SQLite3
- Luna Data Modeler

## dataset downloadable via
https://www.yelp.com/dataset

## we will be focussing on 3 genericly chosen KPI's
1. Average number of friends a users has
2. Average rate/score for some of the businesses/categories
3. Cohort analysis of their returning customers

## available folders & how to use them
### create_model
Once we have extracted the YELP json files from the .tar file we begin by loading them into python dataframes using **JSON_to_SQL** Jupyter notebook. As some objects are nested up to 2 levels down (e.g. BusinessAttributes), and the JSON doens't allow for automatic extraction (using max_level = x), we have to put some effort into extracting all objects 2 levels down. 

> *The exact code used is shown and commented on in the notebook.*

5 main datasets arise:
1. BUSINESS data (including several nested Attributes)
2. USER data
3. CHECK-IN data
4. REVIEW data
5. TIP data

Even after these are extracted, we still notice that several Dataframe columns whe have to use for our KPI's still contain ARRAY's (such as Friends, and Business Categories). This is where the second notebook **table_to_1NF_v1** comes in to Normalize this data using the first method. **1 row per unique combination of either Business/Categories or User/Friend)**

> *we will later comment on the second method: one boolean column per available attribute or category (only for the business_categories, this is no longer feasible for the millions of friends users can have*

In both notebooks the results are eventually loaded into a SQLite3 database for easy querying. The **ERD diagram** shows the final model as it is visualised in Luna Modeling software (trial account)

> *note that some tables, such as Users_friends contain +100million rows, so be sure your CPU/RAM is up to the task before pumping this into SQLite. If it is not consider using a cloud-based solution such as Snowflake of BigQuery*

### KPI1


### KPI2


### KPI3

