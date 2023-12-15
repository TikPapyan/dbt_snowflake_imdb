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

## Version Control with GitHub

### Repository Setup
The project is version-controlled using GitHub, which facilitates collaboration, version tracking, and code management. The process of setting up the repository on GitHub involved the following steps:

1. **Creating a Repository**: A new repository was created on GitHub to host the project files.
2. **Local Git Setup**: The local dbt project directory was initialized as a Git repository.
3. **Committing Files**: All relevant project files were added and committed to the local Git repository.
4. **Pushing to GitHub**: The committed changes were pushed to the GitHub repository using `git push -u origin master`.

### Continuous Integration with GitHub Actions

#### Workflow Creation
The `.github/workflows/dbt_prod.yml` file was created to define the GitHub Actions workflow for continuous integration. This workflow is triggered on every push to the `master` branch. The file includes:

```yaml
name: dbt production run on push branches to main

on:
  push:
    branches: [ master ]

env:
  DBT_TARGET: dev
  DBT_ACCOUNT: ${{ secrets.DBT_CCCOUNT }}
  DBT_USER: ${{ secrets.DBT_USER }}
  DBT_PASSWORD: ${{ secrets.DBT_PASSWORD }}

jobs:
  dbt_run:
    name: dbt refresh and test on push branches to main
    runs-on: ubuntu-latest
    timeout-minutes: 90

    steps:
      - name: Checkout
        uses: actions/checkout@v3

      - name: Setup Python environment
        uses: actions/setup-python@v4
        with:
          python-version: "3.11"

      - name: Install dependencies (first attempt)
        continue-on-error: true
        run: |
          python3 -m pip install --upgrade pip
          pip3 install -r requirements.txt

      - name: Install dbt packages
        run: dbt deps
        working-directory: ./

      - name: Run the models
        run: dbt run
        working-directory: ./

      - name: Run tests
        run: dbt test 
        working-directory: ./
```

The workflow automates the following tasks:

- Checks out the code from the repository.
- Sets up the Python environment.
- Installs dependencies.
- Installs dbt packages.
- Runs dbt models.
- Executes dbt tests.

This automation ensures that every change pushed to the repository undergoes a thorough check, maintaining the integrity and reliability of the codebase.

#### Creating Secrets for Security

It is crucial to securely handle sensitive information like Snowflake credentials. Therefore, GitHub Secrets were created to store the **DBT_ACCOUNT**, **DBT_USER**, and **DBT_PASSWORD**. These secrets are referenced in the workflow, providing secure access to the necessary credentials without exposing them in the code.

Below is a screenshot of secrets creation:
   ![GitHub Secrets Screenshot](https://github.com/TikPapyan/dbt_snowflake_imdb/blob/master/screenshots/github-secret.png)

## Dockerization

### Dockerfile Creation
The project is containerized using Docker, which provides a consistent and isolated environment, ensuring that the dbt project runs smoothly across different setups. The `Dockerfile` is structured as follows:

```dockerfile
FROM python:3.11-slim
WORKDIR /dbt
RUN pip install dbt-snowflake
COPY . .
RUN dbt deps
ENV DBT_PROFILES_DIR /dbt
CMD ["dbt", "run"]
```

This Dockerfile performs the following actions:

 - Starts from a slim Python 3.11 base image.
 - Sets the working directory to **/dbt** within the container.
 - Installs **dbt-snowflake** using pip, enabling dbt to interact with Snowflake.
 - Copies all the files from the current directory (the dbt project files) into the container.
 - Runs dbt **deps** to install dbt dependencies.
 - Sets the **DBT_PROFILES_DIR** environment variable, pointing dbt to the profiles directory.
 - Specifies the default command (**dbt run**) to execute when the container starts.

### Building and Running the Docker Container

#### Building the Docker Image

To build the Docker image from the Dockerfile, the following command is used:

```
docker build -t dbt-project .
```

This command creates a Docker image named **dbt-project** based on the instructions in the Dockerfile.

#### Running the Docker Container
Once the image is built, the dbt project can be run inside a Docker container using the command:

```
docker run dbt-project
```

This command starts a container from the **dbt-project** image and executes the default command (**dbt run**), running the dbt models as defined in the project.

By using Docker, we ensure that our dbt project operates in a controlled environment, mitigating issues related to varying local setups and dependencies.

## Data Visualization with Hex

### Hex Integration
For the data visualization aspect of our project, we integrated Hex, an advanced data analytics and visualization platform, with our Snowflake database and dbt models. The integration process involved:

1. **Connecting Hex to Snowflake**:
   - In Hex, we used the dedicated Snowflake connector to establish a direct connection to our Snowflake database.
   - This required entering credentials for Snowflake, including account details, user name, and password.

2. **Enabling dbt Integration**:
   - We also enabled dbt integration within Hex to directly utilize our dbt models for analysis and visualization.
   - This involved providing specific dbt Cloud settings, such as the version, access URL, environment ID, and a service token for secure access.

Through these integrations, Hex can now access both the raw data in Snowflake and the transformed data via dbt models, providing a comprehensive environment for data analysis and visualization.

### Hex Notebook
A Hex notebook was created to visually explore and analyze the movie data. The notebook serves as an interactive tool where SQL queries can be run against the Snowflake data, and the results are visualized using Hex's powerful graphical capabilities. 

- **Hex Notebook Link**: [View the Hex Notebook](https://app.hex.tech/64aedd26-c085-4914-9bef-aa829a4e3d6d/app/dd1aa85a-8888-44c5-a684-b48a52d3a6ee/latest)

In this notebook, various visualizations were crafted to uncover insights from the IMDb dataset, such as trends over time, ratings distributions, and genre comparisons. The interactive nature of Hex allows for dynamic exploration and deeper understanding of the data, making it an invaluable tool in our data analysis arsenal.

## Conclusion

### Project Summary
This project successfully established a comprehensive data pipeline integrating various technologies to analyze and visualize movie data from the IMDb dataset. Key achievements include:

- **Data Integration**: Seamlessly syncing data from Google Drive to Snowflake via Fivetran.
- **Data Transformation**: Effectively using dbt for data modeling and transformation within Snowflake.
- **Automation and Version Control**: Implementing GitHub Actions for continuous integration, ensuring reliable and consistent code updates.
- **Containerization**: Utilizing Docker to create a consistent environment for running dbt models.
- **Advanced Visualization**: Integrating Hex for dynamic data visualization and analysis, leveraging both raw and transformed data.

The project demonstrates how different technologies can be combined to create a robust data analytics pipeline, from data ingestion and transformation to insightful visualization and analysis.

### Future Directions
To further enhance the project's capabilities and effectiveness, several improvements and extensions can be considered:

1. **Expand Dataset**: Incorporate additional data sources or more extensive IMDb data to enrich the analysis.
2. **Advanced dbt Features**: Explore more complex dbt features like incremental models, tests, and macros to enhance data transformation.
3. **Real-Time Data Integration**: Implement real-time data syncing for more up-to-date analysis.
4. **Extended Visualizations**: Develop more complex visualizations in Hex to uncover deeper insights.
5. **Machine Learning Integration**: Integrate machine learning models for predictive analytics and trend forecasting.
6. **User Interface for Interactivity**: Create a user-friendly interface or dashboard that allows non-technical users to interact with the data and visualizations.

These future directions aim to expand the project's scope, increase its analytical power, and make it more accessible to a broader range of users.

