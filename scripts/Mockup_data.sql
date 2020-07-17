-- Created for mocking up some data for migration
CREATE TABLESPACE anz 
   DATAFILE 'tbs_anz_data.dbf' 
   SIZE 20m;
  
   
create user gcppoc
  identified by gcppoc
  default tablespace anz
  quota 20m on anz;

grant create session TO gcppoc;
grant create table TO gcppoc;
grant create view TO gcppoc;
grant create any trigger TO gcppoc;
grant create any procedure TO gcppoc;
grant create sequence TO gcppoc;
grant create synonym TO gcppoc;


connect gcppoc/gcppoc;

create table gcppoc.test1_tbl as (select * from sys.source$ where 0=1);
alter table gcppoc.test1_tbl add insert_date timestamp;

create trigger gcppoc.trigger1 
before insert
  on gcppoc.test1_tbl 
  for each row
begin
  :new.insert_date := sysdate-12;
end;


insert into gcppoc.test1_tbl
select rownum, mod(rownum,100), trunc(rownum/10),sysdate+12
from sys.source$
where rownum < (select count(*) from sys.source$);
commit;

select * from gcppoc.test1_tbl where rownum < 20;

