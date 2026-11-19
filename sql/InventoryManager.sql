begin;

CREATE FUNCTION updated_at()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = now();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;


create table employees (employee_id integer primary key generated always as identity, location_id integer, name varchar(255), position varchar(100), phone_number varchar(15));
create table store (store_id integer primary key generated always as identity, store_name varchar(255), manager_id integer, address varchar(255), constraint fk_manager_id foreign key (manager_id) references employees(employee_id) on delete set null);
create table products (product_id integer primary key generated always as identity, name varchar(255), brand varchar(255), department varchar(50), SKU varchar(25), MSRP money);
create table warehouse (warehouse_id integer primary key generated always as identity, manager_id integer, address varchar(255), phone_number varchar(15), constraint fk_manager_id foreign key (manager_id) references employees(employee_id) on delete set null);
create table warehouse_inventory (warehouse_id integer, product_id integer, count integer, constraint fk_warehouse_id foreign key (warehouse_id) references warehouse(warehouse_id) on delete cascade, constraint fk_product_id foreign key (product_id) references products(product_id) on delete cascade);
create table shipments (shipment_id integer primary key generated always as identity, warehouse_id integer, store_id integer, shipment_date date, order_date date, order_status varchar(100), est_delivery date);
create table shipment_order (shipment_id integer, product_id integer, count integer, constraint fk_shipment_id foreign key (shipment_id) references shipments(shipment_id) on delete cascade);

create table store_inventory (store_id integer, product_id integer, price money, front_stock integer, back_stock integer, last_updated timestamptz default now(), constraint fk_store_id foreign key (store_id) references store(store_id) on delete cascade);

create table returns (return_id integer primary key generated always as identity, store_id integer, product_id integer, price money, constraint fk_store_id foreign key (store_id) references store(store_id) on delete cascade);

alter table employees add constraint fk_store_id foreign key (location_id) references store(store_id) on delete set null;

CREATE TRIGGER last_updated_at
BEFORE UPDATE ON store_inventory
FOR EACH ROW
EXECUTE FUNCTION updated_at();

create index on employees (employee_id);
create index on employees (location_id);
create index on employees (position);
create index on products (product_id);
create index on warehouse_inventory (product_id);
create index on shipments (shipment_id);
create index on shipments (store_id);
create index on shipments (order_status);
create index on store_inventory (product_id);
create index on returns (return_id);

create index on shipments (order_status) where order_status = 'in progress';


commit;
