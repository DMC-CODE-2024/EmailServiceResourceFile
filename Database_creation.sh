source ~/.bash_profile

source $commonConfigurationFilePath
dbDecryptPassword=$(java -jar  ${APP_HOME}/encryption_utility/PasswordDecryptor-0.1.jar spring.datasource.password)

mysql  -h$dbIp -P$dbPort -u$dbUsername -p${dbDecryptPassword} $appdbName <<EOFMYSQL

insert into sys_param(tag, type, value, feature_name) VALUES 
('email_host', 1, 'smtp.office365.com', 'EmailProcess'), 
('email_port', 1, '587', 'EmailProcess'), 
('email_username', 1, 'support@goldilocks-tech.com', 'EmailProcess'), 
('email_password', 1, 'P@ss1MustChange', 'EmailProcess'), 
('email_tps', 1, '5000', 'EmailProcess'), 
('email_sleep_timer', 1, '20', 'EmailProcess'), 
('email_retry_gap', 1, '5000', 'EmailProcess'), 
('email_max_retry_count', 1, '3', 'EmailProcess'), 
('email_sleep_time', 1, '30', 'EmailProcess'), 
('email_from', 1, 'Info<support@goldilocks-tech.com>', 'EmailProcess'),  
('systemDefaultLanguage', 1, 'en', 'General'); 

INSERT INTO eirs_response_param (tag, value, feature_name, language) VALUES ('mail_signature', 'Regards,\nEIRS Team.\nPlease do not reply on this mail', 'EmailProcess', 'en'); 

INSERT INTO eirs_response_param (tag, value, feature_name, language) VALUES ('mail_signature', 'សូមគោរព\nក្រុម EIRS ។\nសូមកុំឆ្លើយតបតាមអ៊ីមែលនេះ។', 'EmailProcess', 'km');

insert into cfg_feature_alert (alert_id ,description,feature) values 
('alert1601','Email Notification Module <Key> is missing in database configuration','Email Service'),
('alert1602','Email Notification Module - Error occurred while send email for - <emailId>','Email Service'),
('alert1603','Email Notification Module not able to connect with database','Email Service'),
('alert1604','Email Notification Module performance impacted. Not able to meet configured TPS','Email Service');

EOFMYSQL

