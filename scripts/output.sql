
BEGIN;
INSERT INTO rds_configuration (name,value,description)  VALUES (E'tracefile retention',E'10080',E'tracefile expiration specifies the duration in minutes before tracefiles in bdump are automatically deleted.');
INSERT INTO rds_configuration (name,value,description)  VALUES (E'archivelog retention hours',E'0',E'ArchiveLog expiration specifies the duration in hours before archive/redo log files are automatically deleted.');
INSERT INTO test_table (id,presenter)  VALUES (1,E'Ray.Wang');

COMMIT;

