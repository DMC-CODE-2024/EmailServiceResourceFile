source ~/.bash_profile

source $commonConfigurationFile
dbDecryptPassword=$(java -jar  ${pass_dypt} dbEncyptPassword)

mysql  -h$dbIp -P$dbPort -u$dbUsername -p${dbDecryptPassword} $appdbName <<EOFMYSQL

insert ignore into sys_param(tag,  value, feature_name , DESCRIPTION,TYPE,ACTIVE,remark,user_type,modified_by ) VALUES 
('email_host',  'smtp.office365.com', 'EmailProcess' ,'host name of email server',0,1,'','',''), 
('email_port',  '587', 'EmailProcess','port  of email server',0,1,'','',''), 
('email_username',  'support@goldilocks-tech.com', 'EmailProcess','username   of email server',0,1,'','',''), 
('email_password',  'P@ss1MustChange', 'EmailProcess','password  of email server',0,1,'','',''), 
('email_tps',  '5000', 'EmailProcess','tps required for  email server',0,1,'','',''), 
('email_sleep_timer', '20', 'EmailProcess','time gap in between email to be send ',0,1,'','',''), 
('email_retry_gap',  '5000', 'EmailProcess',' gap after which email retry happen',0,1,'','',''), 
('email_max_retry_count',  '3', 'EmailProcess','retry count for email send',0,1,'','',''), 
('email_sleep_time',  '30', 'EmailProcess','time gap when new batch for email execute',0,1,'','',''), 
('email_from',  'Info<support@goldilocks-tech.com>', 'EmailProcess','email from sender ',0,1,'','',''),  
('systemDefaultLanguage',  'en', 'General' ,'default system language',0,1,'','',''); 

INSERT ignore INTO eirs_response_param (tag, value, feature_name, language) VALUES ('mail_signature', 'Regards,\nEIRS Team.\nPlease do not reply on this mail', 'EmailProcess', 'en'); 

INSERT ignore INTO eirs_response_param (tag, value, feature_name, language) VALUES ('mail_signature', 'សូមគោរព\nក្រុម EIRS ។\nសូមកុំឆ្លើយតបតាមអ៊ីមែលនេះ។', 'EmailProcess', 'km');

insert  ignore into cfg_feature_alert (alert_id ,description,feature) values 
('alert1601','Email Notification Module <Key> is missing in database configuration','EmailProcess'),
('alert1602','Email Notification Module - Error occurred while send email for - <emailId>','EmailProcess'),
('alert1603','Email Notification Module not able to connect with database','EmailProcess'),
('alert1604','Email Notification Module performance impacted. Not able to meet configured TPS','EmailProcess');

EOFMYSQL

