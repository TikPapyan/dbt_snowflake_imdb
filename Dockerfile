FROM python:3.11-slim
WORKDIR /dbt
RUN pip install dbt-snowflake
COPY . .
RUN dbt deps
ENV DBT_PROFILES_DIR /dbt
CMD ["dbt", "run"]
