
show databases;
use world;
select database();

show tables;

select *
from city;

select *
from language;

select *
from country;

create database testing;

show tables;

select name, District, Population
from city;

# call a function by selecting
select now();

select *
from language;

select CountryCode,
       Language,
       Percentage
from language
where Language = "Arabic"
  and Percentage < 5
order by CountryCode desc;

# left join picks every left
# and then tests condition on right
select cl.CountryCode,
       c.Name,
       cl.Language,
       c.Population,
       cl.Percentage
from language as cl
         left join country c
                   on cl.CountryCode
                       = Code
where Language = "Arabic"
   or Language = "English"
# and cl.Percentage>10
order by cl.Percentage desc;


# inner join picks
# overlaping to condition on both sides
select cl.CountryCode,
       c.Name,
       cl.Language,
       c.Population,
       cl.Percentage
from language as cl
         inner join country c
                    on cl.CountryCode
                        = Code
where Language = "Arabic"
   or Language = "English"
order by cl.Percentage desc;


select cl.CountryCode,
       c.Name,
       cl.Language,
       c.Population,
       cl.Percentage
from language as cl
         left join country c
                   on CountryCode
                       = Code
where Population between 0 and 50000
    and Language = 'Arabic'
   or Language = 'English'
order by Language;

select cl.CountryCode,
       c.Name,
       cl.Language,
       c.Population,
       cl.Percentage
from language as cl
         left join country c
                   on CountryCode
                       = Code
where Language like 'Ara%'
order by Language desc;


# distinct pick,rather useful in left join
select distinct Language
from language as cl
         left join country c
                   on Percentage
where Language = 'Arabic'
order by Language;


# user defined escape,
# enlarge test vairable by ignoring
select LifeExpectancy, Name
from country
where LifeExpectancy like '.7%' escape '.'
order by Name;


# where in example
select Name, Region, LifeExpectancy
from country
where LifeExpectancy in ('77%', '78.%', '79%')
order by LifeExpectancy desc;

# limit results to first 5
select Name, Region, LifeExpectancy
from country
order by LifeExpectancy desc
limit 5;


# skip first one and limit result to next 5
select Name, Region, LifeExpectancy
from country
order by LifeExpectancy desc
limit 1, 5;

# give (limited)only one result which lays after 5 line
select Name, Region, LifeExpectancy
from country
order by LifeExpectancy desc
limit 1 offset 5;

# 0 is false ellers true
select 0 is not null,
       '' is not null,
       null is not null;


# count null results
select count(*)
from country
where LifeExpectancy is null;

# count non null
select count(*)
from country
where LifeExpectancy is not null;


select c.Name, country.Name
from country
         inner join city c on country.Name = c.Name
order by c.Name;

select city.Name, country.Name
from country
         left join city
                   on country.Name = city.Name
order by country.Name;

# many inner joins
select Continent,
       country.Name,
       country.Capital,
       language.Language,
       language.Percentage
from country
         inner join city
                    on city.Name = country.Name
         inner join language
                    on language.Percentage < 10
order by country.Name;


# group by two columns
select Continent, Region, count(country.Name)
from country
group by Region, Continent
order by Continent;

# sum function
select Region,
       sum(city.Population),
       sum(country.SurfaceArea)
from country
         inner join city
group by Region;


# min, max functions
select Region                   as subContinent,
       min(country.SurfaceArea) as minArea,
       max(country.SurfaceArea) as maxArea
from country
group by Region
order by Region desc;


# cant use where for group by,
# then use having instead.
select Region,
       avg(SurfaceArea)
           as avgSurface
from country
group by Region
having avgSurface < 400000;

# subquery
/*Instead of executing two queries at different time,
  you nest the first query in the second query */
select Name, gnp, avg(country.LifeExpectancy) as longi
from country
where (select avg(GNP) > 600000)
group by GNP;

/*
A common table expression or CTE allows you
to create a temporary result set within a query.
*/
with money_talks as (select Name, gnp, avg(country.LifeExpectancy) as longi
                     from country
                     where (select avg(GNP) > 600000)
                     group by GNP)
select Name,
       GovernmentForm,
       HeadOfState,
       money_talks.GNP,
       longi
from country
         inner join money_talks
                    using (Name)
order by longi desc;


#  subquiry - different style
/*select mpr.HeadOfState,
      mpr.GovernmentForm,
      mpr.Name,
      mpr.longy,
      mpr.GNP
       from (select GovernmentForm,HeadOfState,GNP, Name, avg(country.LifeExpectancy) as longy
    from country
      where (select avg(GNP) > 600000) ) mpr
      inner join country
      using (GNP)
group by mpr.Name;*/

# union.. just summoans columns inline
# union vs join:
# a join appends result sets horizontally
# while a union appends result sets vertically.
select distinct Name, Region
from country
union distinct
select Name, Population
from city;

# intersect---
/*
select c.Name, country.Name
from country
         inner join city c on country.Name = c.Name
order by c.Name;
*/
select Name
from country
intersect
select Name
from city
order by Name;

/*except-
  returns the distinct rows from the first
  select statement which are not output by the
  second select statement.*/
select Name
from country
except
select Name
from city
order by Name;


use testing;
show tables;

select *
from contacts;

select *
from tester;

select *
from region_areas;

create table tester
(
    id         int auto_increment,
    some_text  varchar(300),
    begin_date date,
    event_time timestamp default current_time,
    cost       decimal(15, 2) not null,
    primary key (id)
);

describe tester;

insert into tester (some_text, begin_date, event_time, cost)
values ('ofdsløkfan', 20220809, current_time, 23);

create table contacts
(
    id            int auto_increment,
    first_name    varchar(50) not null,
    last_name     varchar(50) not null,
    full_name     varchar(101)
#         a virtual row !!! of concatenation
                  as (concat(first_name, ' ', last_name)) virtual,
    phone         varchar(100),
    contact_group varchar(50) default 'General',
    primary key (id)
);

# insert into
insert into contacts(first_name, last_name, phone, contact_group)
values ('Jane', 'Doe', '(408)-456-8934', 'Leads');
insert into contacts(first_name, last_name, phone, contact_group)
values ('Roberto', 'carlos', '(408)-242-3845', default);

# alternative insert method in mariadb/mysql
insert into tester
set some_text = 'this is something',
    cost=(23.56);

insert into contacts
set first_name = 'empty',
    last_name= 'testing.tester.some_text';

# last inserted id function called
select last_insert_id() as lastEntryId;

# multiple insert
insert into contacts(first_name, last_name, phone, contact_group)
values ('James', 'Smith', '(408)-232-2352', 'Customers'),
       ('Michael', 'Smith', '(408)-232-6343', 'Customers'),
       ('Maria', 'Garcia', '(408)-232-3434', 'Customers');

# insert into via select from one table to another !!!
insert into contacts(first_name, last_name)
select some_text, some_text
from tester
where id = 5;

# insert into select summary data/subquery
create table region_areas
(
    region_name varchar(100)   not null,
    region_area decimal(15, 2) not null,
    primary key (region_name)
);

insert into region_areas
    (region_name, region_area)
select world.country.Name,
       sum(SurfaceArea)
from world.country
         inner join world.city
                    on country.Code = city.CountryCode
group by world.country.Name;

# update the latest insert
update contacts
set first_name = 'fulled'
where id = (select last_insert_id());

# update with replace
update contacts
# set phone=replace(phone,'408','999')
set phone=replace(phone, null, '(000)12345678')
# where contact_group='customers'
;

# delete row
/*If you delete rows from the parent table,
  the corresponding rows from the child tables are
  automatically deleted if the foreign key
  constraints use on delete cascade action.
  --and child cannot be deleted without dealing with parent*/
delete
from contacts
#     where phone=null;
where contact_group = 'General';

# see database u r using
select database();

# database management
create or replace database playground;
show databases;

show create database playground;
show character set;

alter database playground
    character set = 'hp8'
    collate = 'hp8_english_ci';

show create database playground;
create database dropit;
show databases;
drop database dropit;

show databases like 'play%';

show databases
    where `database` not in
          ('information_schema',
           'mysql',
           'performance_schema',
           'sys');

select database();

# table specs--
/*create table
  [or replace]
  [if not exists]
  table_name(
    column_1_definition,
    column_2_definition,
    ...,
    table_constraints
) engine=storage_engine;
*/

# sample table--
/*create table projects(
    project_id int auto_increment,
    project_name varchar(255) not null,
    begin_date date,
    end_date date,
    cost decimal(15,2) not null,
    created_at timestamp default current_timestamp,
    primary key(project_id)
);
*/

# foreign  & primary key
# in milestones project--
/*
primary key(milestone_id, project_id)
foreign key(project_id)
    references projects(project_id)
*/

/*drop table
  if exists
  table_name;
*/

# column specs--
/*
column_name
data_type(length)
[not null]
[default value]
[auto_increment]
column_constraint;
*/

# sjå engines--
show engines;
select *
from information_schema.ENGINES;

# sjå current engine--
select @@global.storage_engine;

# sjå storage engine of a table
/*
select
    table_name,
    engine
from
    information_schema.tables
where
    table_schema='nation'
    table_name = 'countries';
  */

use testing;

# alter table/column--
alter table tester
    add
        newest_column text      default 'newest column'
        first,
    add
        timer         timestamp default current_time
        after id;

# modify table/column --
# cant modify text to string !!
alter table tester
    modify newest_column varchar(22);

# rename/modify a column
alter table tester
    change column newest_column sørlandet mediumtext;

# drop a column
alter table tester
    add column_to_drop int not null;
alter table tester
    drop column_to_drop;

# see table description--
describe tester;

select *
from tester;

# rename a table --
alter table tester
    rename to exercise;

show tables;
describe exercise;

# drop table --
/*MariaDB will retain all user privileges
  on the removed table. In case you create
  a new table with the same name as
  the table that you dropped, all the privileges
  on the dropped table will apply to the new table.
  It could be a potential security risk
  that you should be aware of.*/

create table mountains
(
    name text
);
insert into mountains
values ('klimanjaro');
create table oceans
(
    name text
);
show tables;
select *
from mountains;
drop table mountains, oceans; /*removes */

select database();

# show database and tables
show tables from mysql;
show full tables from world; /*showinf table type
                               such as base table,
                               view, or sequence*/
show tables like '%c%';
show full tables like '%c%';
show full tables from mysql
    where table_type = 'view';

# truncate -- delete all rows
    /*truncate table statement
    drops and recreates the table
    instead of removing rows one by one. */
select database();
show databases ;
use testing;
show tables ;
create table truncular (idd int not null);
alter table truncular
add texty text;
describe truncular;
truncate table truncular; /*not functioning?*/

# a stored procedure --
/*delimiter $$

create procedure load_items(in row_count int)
begin
    declare counter int default 0;
    declare str varchar(255) default '';

    while counter < row_count do
       set str = concat('Item #',counter);
       set counter = counter + 1;

       insert into items(name)
       values(str);
    end while;
end$$

delimiter ;*/

# primary key --
/*When you create a table with a primary key,
  MariaDB automatically creates a btree index
  called primary that includes the primary key column
  or columns.
By default, primary key columns are implicitly
  imposed not null constraints, therefore, you don’t
  need to explicitly specify the not null constraints
  for the primary key columns.*/

create table plodukt(
    pk_column int primary key
);

create table products(
    pk_column1 varchar (11),
    pk_column2 int,
    primary key(pk_column1,pk_column2)
);

show indexes from products;

/*alter table products
    add constraint
        primary key (pk_column3);*/

alter table products
drop primary key;

# foreign key

alter table truncular
    add cost decimal (15,2) null ;

alter table truncular
    add constraint fk_deci
            foreign key (cost)
            references testing.exercise (cost)
on delete cascade
on update cascade ;

describe truncular;

alter table truncular
drop constraint fk_deci;

# check constraint

/*A check constraint checks a value
  in a column or group of columns before
  inserting or updating to make sure that
  this value satisfies a Boolean expression.
  can be more than one in a table..

::  column_name datatype [constraint name4cons] check(expression)
  */

create table classes(
    class_id int auto_increment,
    class_name varchar(255) not null,
    student_count int
        check(student_count >0),
    primary key(class_id)
);
alter table classes
add constraint newons
check (  class_name is not null);

describe classes;
show create table classes;

alter table classes
drop constraint newons;

# unique
/*constraint constraint_name
unique(column_list)

alter table table_name
add constraint constraint_name
unique (column_list);

drop index_name on table_name;

  alter table table_name
drop index index_name;

 */

# not null
/*
column_name datatype not null;

# Adding a not null constraint to an existing column
1)
update courses
set summary = 'N/A'
where summary is null;
2)
alter table courses
modify summary varchar(255) not null;

# Removing a not null constraint
# --just add value in it
alter table courses
modify summary varchar(255);

*/



