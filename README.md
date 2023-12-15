# Data Analytics and Visualization Project

## Introduction
This project is centered around data analytics and visualization, with a focus on processing and analyzing movie data from the IMDb dataset. The goal is to extract meaningful insights and trends from the data, such as average ratings, counts per year, and high earnings, and to present these insights through effective data visualizations. This project encompasses the entire data pipeline, from data ingestion and transformation to analysis and visualization.

## Technologies Used
- **IMDb Dataset**: Serves as the primary data source, offering a comprehensive collection of movie data.
- **Google Drive**: Used for storing the IMDb dataset in a cloud-based platform, facilitating easy access and integration.
- **Fivetran**: Connects Google Drive to Snowflake, enabling automated data transfer and synchronization.
- **Snowflake**: Acts as the data warehouse, providing robust data storage, and efficient querying capabilities.
- **dbt (data build tool)**: Utilized for transforming data within Snowflake. It allows for version-controlled and modular transformations.
- **GitHub Actions**: Automates the CI/CD pipeline, ensuring consistent and error-free deployment of dbt models.
- **Docker**: Provides a consistent and isolated environment for running the dbt project, enhancing portability and scalability.
- **Hex**: Used for advanced data analytics and visualization. Hex allows for creating interactive notebooks that connect directly to Snowflake and dbt models.

This diverse set of technologies enables a comprehensive approach to data analytics, from initial data ingestion to in-depth analysis and visual presentation.

---

For further information on each technology and step in the pipeline, refer to the subsequent sections of this documentation.

## Data Source and Integration

### IMDb Dataset
The IMDb dataset utilized in this project is the "IMDb TOP 1000 WITH DESCRIPTION," sourced from [Kaggle](https://www.kaggle.com/datasets/akashkotal/imbd-top-1000-with-description/code). This dataset offers an extensive collection of the top 1000 movies as rated by IMDb users, including key details such as movie titles, directors, stars, release years, runtime, genres, votes, descriptions, and ratings. The depth and breadth of this dataset make it an ideal source for insightful analysis of movie trends, popularity, and critical reception.

### Snowflake Setup and Integration

#### Configuring Snowflake
The initial step in setting up our data warehouse involves configuring Snowflake to handle our data needs. This process includes setting up roles, users, and warehouses. Below is a screenshot of the Snowflake script used:
![Snowflake Script Screenshot](https://github.com/TikPapyan/dbt_snowflake_imdb/blob/master/screenshots/snowflake_script.png)

Creating user roles and permissions is crucial in Snowflake to ensure secure and organized access to the data. This setup facilitates effective management and operation of our data warehouse.

#### Connecting Snowflake to Fivetran
To connect Snowflake as a destination to Fivetran, specific settings and credentials are configured in Fivetran. This integration enables the automated transfer of data from Google Drive (where the IMDb dataset is stored) to Snowflake. Detailed connection settings include specifying the Snowflake role, user, warehouse, database, and other necessary parameters to establish a successful connection.

Below is a screenshot of the Fivetran to Snowflake connection setup:
![Fivetran Connection Screenshot](https://github.com/TikPapyan/dbt_snowflake_imdb/blob/master/screenshots/fivetran_connection.png)

With these configurations, Snowflake is ready to receive and store data from our primary data source, paving the way for the next steps in data transformation and analysis.

## Local Environment and dbt Setup

### Setting up the dbt Environment
The setup of our dbt environment involved several key steps to ensure a smooth and efficient data modeling process:

1. **Creating a dbt Directory**:
   - A dedicated directory was created specifically for the dbt project to organize and isolate the dbt-related files.

2. **Activating Virtual Environment**:
   - A virtual environment was activated within this directory. This helps manage dependencies and ensures that the project's requirements do not conflict with other Python projects.

3. **Installing dbt for Snowflake**:
   - The `dbt-snowflake` adapter was installed within the virtual environment. This adapter is necessary for dbt to interact with the Snowflake database.

4. **Initializing the dbt Project**:
   - The dbt project was initialized using the `dbt init dbt_project` command. This command structures the dbt project with the appropriate directories and files for development.

5. **Configuring Snowflake Connection**:
   - During the initialization process, credentials for the Snowflake connection were inputted into the prompt that appeared.
   - A `profiles.yml` file was autogenerated as a result, containing the necessary configuration for dbt to connect to Snowflake.

Below is a screenshot of the configured `profiles.yml`:
   ![profiles.yml Screenshot](https://github.com/TikPapyan/dbt_snowflake_imdb/blob/master/screenshots/profiles.png)

6. **Creating Model Layers**:
   - Three layers of models (analytics, basic, filter) were created to organize the dbt models based on their functionality.
   - The `dbt_project.yml` file was updated to reflect these layers.

Below is a screenshot of the updated `dbt_project.yml`:
   ![dbt_project.yml Screenshot](https://github.com/TikPapyan/dbt_snowflake_imdb/blob/master/screenshots/dbt_project.png)

7. **Testing the Configuration**:
   - The dbt environment and connection were tested using the `dbt debug` command to ensure proper setup and connectivity.

8. **Running dbt Models**:
   - Finally, dbt models were executed using the `dbt run` command, with the option to run specific model layers using `dbt run --models <layer_name>`.

This process established a robust foundation for developing, testing, and running dbt models, thereby enabling effective data transformations within our Snowflake data warehouse.

