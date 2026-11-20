begin;

create role manager;
create role wh_manager;
create role floor_employee;
create role wh_employee;
create role hr_admin;

alter role manager createrole;
alter role wh_manager createrole;

grant usage on schema public to manager;
grant usage on schema public to wh_manager;
grant usage on schema public to hr_admin;

grant select on all tables in schema public to manager;
grant select on all tables in schema public to wh_manager;

grant select, update, delete, insert on products to hr_admin with grant option;
grant select, update, delete, insert on returns to hr_admin with grant option;
grant select, update, delete, insert on store_inventory to hr_admin with grant option;
grant select, update, delete, insert on shipment_order to hr_admin with grant option;
grant select, update, delete, insert on employees to hr_admin with grant option;
grant select, update, delete, insert on store to hr_admin with grant option;
grant select, update, delete, insert on warehouse to hr_admin with grant option;
grant select, update, delete, insert on warehouse_inventory to hr_admin with grant option;
grant select, update, delete, insert on shipments to hr_admin with grant option;

grant select, update, delete, insert on products to manager with grant option;
grant select, update, delete, insert on shipments to manager with grant option;
grant select, update, delete, insert on returns to manager with grant option;
grant select, update, delete, insert on store_inventory to manager with grant option;
grant select, update, delete, insert on shipment_order to manager with grant option;
grant select on warehouse to manager;
grant select on warehouse_inventory to manager;


grant select, update, delete, insert on warehouse to wh_manager with grant option;;
grant select, update, delete, insert on warehouse_inventory to wh_manager with grant option;
grant select, update, delete, insert on shipments to wh_manager with grant option;
grant select, update, delete, insert on shipment_order to wh_manager with grant option;
grant select, update, delete, insert on products to wh_manager with grant option;

grant select, update, insert on returns to floor_employee;
grant select, update, insert on store_inventory to floor_employee;
grant select on shipments to floor_employee;
grant select on products to floor_employee;
grant select on warehouse_inventory to floor_employee;
grant select on warehouse to floor_employee;
grant select on shipment_order to floor_employee;

grant select on warehouse to wh_employee;
grant select on products to wh_employee;
grant select, update on warehouse_inventory to wh_employee;
grant select, update on shipments to wh_employee;
grant select, insert, update on shipment_order to wh_employee;
grant select on store to wh_employee;

commit;

-- Add in specific employees to each role after this
