begin;

create user Manager_Alex with password '1234' in role manager;
create user WH_Manager_Haywood with password '1234' in role wh_manager;
create user MichaelSmith with password '1234' in role floor_employee;
create user HectorGarcia with password '1234' in role hr_admin;
create user AlyssaMitski with password '1234' in role wh_employee;

commit;
