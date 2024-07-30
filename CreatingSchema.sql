--create my schema
create schema if not exists ollie_schema;

--use created schema
use schema til_portfolio_projects.ollie_schema;

--look at values
select * from til_portfolio_projects.staging.lego_inventory_parts;

--find max length for string fields
select max(length(part_num)) as len from til_portfolio_projects.staging.lego_inventory_parts;

--create colors table
create or alter table colors (
id integer,
name varchar(50),
rgb varchar(6),
id_trans char);

--create inventories table
create or alter table inventories (
id integer,
"version" integer,
set_num varchar(16));

--create inventory_parts table
create or alter table inventory_parts (
	inventory_id integer,	
	part_num varchar(15),	
	color_id integer,	
	quantity integer,	
	is_spare varchar(1)	
);

--create inventory_sets table
create or alter table inventory_sets (
	inventory_id integer,	
	set_num varchar(16),	
	quantity integer	
);

--create parts table
create or alter table parts (
	part_num varchar(15),	
	name varchar(223),	
	part_cat_id integer	
);

--create part_categories table
create or alter table part_categories (
	id integer,	
	name varchar(44)	
);

--create sets table
create or alter table sets (
	set_num varchar(16),	
	name varchar(95),	
	year integer,	
	theme_id integer,	
	num_parts integer	
);

--create themes table
create or alter table themes (
	id integer,	
	name varchar(32),	
	parent_id integer	
);

--Fill in data
insert into colors (
select *
from til_portfolio_projects.staging.lego_colors
);
insert into inventories (
select *
from til_portfolio_projects.staging.lego_inventories
);
insert into inventory_parts (
select *
from til_portfolio_projects.staging.lego_inventory_parts
);
insert into inventory_sets (
select *
from til_portfolio_projects.staging.lego_inventory_sets
);
insert into parts (
select *
from til_portfolio_projects.staging.lego_parts
);
insert into part_categories (
select *
from til_portfolio_projects.staging.lego_part_categories
);
insert into sets (
select *
from til_portfolio_projects.staging.lego_sets
);
insert into themes (
select *
from til_portfolio_projects.staging.lego_themes
);

-- add primary keys
alter table colors add primary key (id);
alter table inventories add primary key (id);
alter table parts add primary key (part_num);
alter table part_categories add primary key (id);
alter table sets add primary key (set_num);
alter table themes add primary key (id);

--add foreign keys
alter table inventory_parts add foreign key (inventory_id) references inventories(id);
alter table inventory_parts add foreign key (part_num) references parts(part_num);
alter table inventory_parts add foreign key (color_id) references colors(id);
alter table parts add foreign key (part_cat_id) references part_categories(id);
alter table inventory_sets add foreign key (inventory_id) references inventories(id);
alter table inventory_sets add foreign key (set_num) references sets(set_num);
alter table sets add foreign key (theme_id) references themes(id);
alter table inventories add foreign key (set_num) references sets(set_num);
