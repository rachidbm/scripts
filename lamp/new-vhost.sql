-- mysql statements to add a new admin user
-- replace VHOST by username

CREATE DATABASE `VHOST`;
CREATE USER `VHOST`@localhost IDENTIFIED BY 'VHOST'; 
GRANT ALL ON `VHOST`.* TO `VHOST`@localhost;
-- UPDATE mysql.user SET Grant_priv='Y' WHERE user='VHOST';
FLUSH PRIVILEGES;
