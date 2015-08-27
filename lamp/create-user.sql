-- mysql statements to add a new admin user
-- replace USERNAME by username
CREATE USER USERNAME@localhost IDENTIFIED BY 'PASSWORD'; 
GRANT ALL ON *.* TO USERNAME@localhost;
UPDATE mysql.user SET Grant_priv='Y' WHERE user='USERNAME';
FLUSH PRIVILEGES;
