CREATE OR REPLACE STAGE DW_GAME_EVENTS_S3
URL = 's3://snowflake-bucketers/game_events/'
FILE_FORMAT = (FORMAT_NAME = 'LANDING_CSV' );

CREATE OR REPLACE STAGE DW_GAMES_S3
URL = 's3://snowflake-bucketers/games/'
FILE_FORMAT = (FORMAT_NAME = 'LANDING_CSV' );

CREATE OR REPLACE STAGE DW_PLAYERS_S3
URL = 's3://snowflake-bucketers/players/'
FILE_FORMAT = (FORMAT_NAME = 'LANDING_CSV' );

SHOW STAGES;

CREATE OR REPLACE PIPE GAME_EVENT_PIPE
AUTO_INGEST =TRUE 
AS COPY INTO GAME_EVENTS FROM @DW_GAME_EVENTS_S3
    FILE_FORMAT = (FORMAT_NAME = LANDING_CSV)
    PATTERN = '.*game_events_.*\.csv';

CREATE OR REPLACE PIPE GAMES_PIPE
AUTO_INGEST =TRUE 
AS COPY INTO GAMES FROM @DW_GAMES_S3
    FILE_FORMAT = (FORMAT_NAME = LANDING_CSV)
    PATTERN = '.*GAMES_.*\.csv';

CREATE OR REPLACE PIPE PLAYERS_PIPE
AUTO_INGEST =TRUE 
AS COPY INTO GAME_EVENTS FROM @DW_PLAYERS_S3
    FILE_FORMAT = (FORMAT_NAME = LANDING_CSV)
    PATTERN = '.*players_.*\.csv';

SHOW PIPES;

SELECT SYSTEM$PIPE_STATUS('GAME_EVENT_PIPE');
SELECT SYSTEM$PIPE_STATUS('GAMES_PIPE');
SELECT SYSTEM$PIPE_STATUS('PLAYERS_PIPE');

CREATE SCHEMA LANDING;
CREATE SCHEMA STAGING ;
CREATE SCHEMA TARGET;

CREATE STAGE PLAYERS_INT_STG
STORAGE_INTEGRATION = FOOTBALL_S3_INTEGRATION
FILE_FORMAT = LANDING_CSV
URL = 's3://snowflake-bucketers/players/';

LIST @GAME_EVENTS_INT_STG;

CREATE STORAGE INTEGRATION FOOTBALL_S3_INTEGRATION
TYPE = external_stage
STORAGE_PROVIDER ='S3'
ENABLED = TRUE 
STORAGE_AWS_ROLE_ARN = 'arn:aws:iam::533267217250:role/aws-s3-snowflake'
STORAGE_ALLOWED_LOCATIONS = ('s3://snowflake-bucketers/');

GRANT USAGE ON INTEGRATION FOOTBALL_S3_INTEGRATION TO ROLE ACCOUNTADMIN;

SHOW INTEGRATIONS;

DESC INTEGRATION FOOTBALL_S3_INTEGRATION;

DROP STORAGE INTEGRATION FOOTBALL_S3_INTEGRATION;

DROP STAGE DW_GAME_EVENTS_S3;

LIST @DW_GAME_EVENTS_S3;

SHOW PIPES;

