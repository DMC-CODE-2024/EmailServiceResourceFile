source ~/.bash_profile

source $commonConfigurationFilePath
dbDecryptPassword=$(java -jar  ${APP_HOME}/encryption_utility/PasswordDecryptor-0.1.jar spring.datasource.password)

mysql  -h$dbIp -P$dbPort -u$dbUsername -p${dbDecryptPassword} $appdbName <<EOFMYSQL

insert ignore into sys_param(tag, type, value, feature_name , DESCRIPTION,TYPE,ACTIVE,remark,user_type,modified_by ) VALUES 
('email_host', 1, 'smtp.office365.com', 'EmailProcess' ,'host name of email server',0,1,'','',''), 
('email_port', 1, '587', 'EmailProcess','port  of email server',0,1,'','',''), 
('email_username', 1, 'support@goldilocks-tech.com', 'EmailProcess','username   of email server',0,1,'','',''), 
('email_password', 1, 'P@ss1MustChange', 'EmailProcess','password  of email server',0,1,'','',''), 
('email_tps', 1, '5000', 'EmailProcess','tps required for  email server',0,1,'','',''), 
('email_sleep_timer', 1, '20', 'EmailProcess','time gap in between email to be send ',0,1,'','',''), 
('email_retry_gap', 1, '5000', 'EmailProcess',' gap after which email retry happen',0,1,'','',''), 
('email_max_retry_count', 1, '3', 'EmailProcess','retry count for email send',0,1,'','',''), 
('email_sleep_time', 1, '30', 'EmailProcess','time gap when new batch for email execute',0,1,'','',''), 
('email_from', 1, 'Info<support@goldilocks-tech.com>', 'EmailProcess','email from sender ',0,1,'','',''),  
('systemDefaultLanguage', 1, 'en', 'General' ,'default system language',0,1,'','',''); 

INSERT INTO eirs_response_param (tag, value, feature_name, language) VALUES ('mail_signature', 'Regards,\nEIRS Team.\nPlease do not reply on this mail', 'EmailProcess', 'en'); 

INSERT INTO eirs_response_param (tag, value, feature_name, language) VALUES ('mail_signature', 'សូមគោរព\nក្រុម EIRS ។\nសូមកុំឆ្លើយតបតាមអ៊ីមែលនេះ។', 'EmailProcess', 'km');

insert into cfg_feature_alert (alert_id ,description,feature) values 
('alert1601','Email Notification Module <Key> is missing in database configuration','Email Service'),
('alert1602','Email Notification Module - Error occurred while send email for - <emailId>','Email Service'),
('alert1603','Email Notification Module not able to connect with database','Email Service'),
('alert1604','Email Notification Module performance impacted. Not able to meet configured TPS','Email Service');

EOFMYSQL

