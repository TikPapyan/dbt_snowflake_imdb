SELECT "YEAR_OF_RELEASE", COUNT(*) AS number_of_movies
FROM FIVETRAN_DATABASE.GOOGLE_DRIVE.IMDB
GROUP BY "YEAR_OF_RELEASE"
