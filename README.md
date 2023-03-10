# yelp_dataset
Getting started with the Yelp Dataset JSON files, and performing some first analytis

## technologies used
- python3
- jupyter notebook
- SQLite3
- Luna Data Modeler
- R

## dataset location
to be downloaded from https://www.yelp.com/dataset

## Answerables
we will be focussing on 3 genericly chosen KPI's
1. Average number of friends a users has
2. Average rate/score for some of the businesses/categories
3. Cohort analysis of their returning customers

## folder structure 
> & how to use them
### create_model
Once we have extracted the YELP json files from the .tar file we begin by loading them into python dataframes using the **JSON_to_SQL** Jupyter notebook. As some objects are nested up to 2 levels down (e.g. BusinessAttributes), and the JSON doesn't allow for automatic extraction (using max_level = x), we have to put some effort into extracting all objects 2 levels down. 

> *The exact code used is shown and commented on in the notebook.*

5 main datasets arise:
1. BUSINESS data (including several nested Attributes)
2. USER data
3. CHECK-IN data
4. REVIEW data
5. TIP data

Even after these are extracted, we notice that several Dataframe columns (need for our answerables) still contain ARRAY's (such as Friends, and Business Categories). This is where the second notebook **table_to_1NF_v1** comes in to Normalize this data using the first method: **1 row per unique combination of either Business/Categories or User/Friend)**

> *we will later comment on the second method: one boolean column per available attribute or category (only for the business_categories, this is no longer feasible for the millions of friends users can have*

In both notebooks the results are eventually loaded into a SQLite3 database for easy querying. The **ERD diagram** shows the final model as it is visualised in Luna Modeling software (trial account)

> *note that some tables, such as Users_friends contain +100million rows, so be sure your CPU/RAM is up to the task before pumping this into SQLite. If it is not consider using a cloud-based solution such as Snowflake of BigQuery*

### KPI1
This folder shows the SQLite3 code we used to answer the first KPI (as well as screenshot of the results)

### KPI2
This folder shows the SQLite3 code we used to answer the second KPI (as well as screenshot of the results)

### KPI3
This folder shows the SQLite3 code we used to create a basic **cohort analysis* for 2019, as well as the results exported into an .xlsx file. Please note this model is far from complete and can be expanded on e.g. by somehow including the *amount of users who made the review*, instead of the blank reviews.

### Kmeans clustering
As a teaser (to be further developed at a later stage) I have added two scripts which can be the start of a small Machine Learning project: the [kmeans clustering algorithm](https://www.youtube.com/watch?v=4b5d3muPQmA). These are:
1. **table_to_1NF_v2** which is a Jupyter Notebook for extracting the Business Categories arrays using a second method: **1 row per Business; 1 boolean column per unique category**
2. An R script **kmeans_clustering.R** which shows how you can apply this algorithm (hint: the booleans serve as the axes on which a business can have either 0 or 1). The result would then be x number of clusters with business which resemble eachother based on categories.
> the only limit to how much axes you can add to make your cluster more precise is your imagination! However: be sure to use the pre-defined "normalize" and "denormalize" functions if the Axis you wish to add is not on a 0-1 scale.