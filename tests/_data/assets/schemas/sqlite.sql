

drop table if exists co_invoices;
            
create table co_invoices
    (
    inv_id          integer constraint co_invoices_pk primary key autoincrement,
    inv_cst_id      integer,
    inv_status_flag integer,
    inv_title       text,
    inv_created_at  text
);
            
create index co_invoices_inv_created_at_index
    on co_invoices (inv_created_at);
            
create index co_invoices_inv_cst_id_index
    on co_invoices (inv_cst_id);
            
create index co_invoices_inv_status_flag_index
    on co_invoices (inv_status_flag);
            


drop table if exists objects;
            
create table objects
    (
    obj_id     integer constraint objects_pk primary key autoincrement,
    obj_name   text not null,
    obj_type   integer not null
);
            


drop table if exists co_sources;
            
create table co_sources
    (
    id          integer constraint co_sources_pk primary key autoincrement,
    username    text,
    source      text
);
            
create index co_sources_username_index
    on co_sources (username);
            


drop table if exists table_with_uuid_primary;
            
create table table_with_uuid_primary
(
    uuid        text constraint uuid_pk primary key,
    int_field   integer
);
            


drop table if exists stuff;
            
create table stuff
(
    stf_id      integer constraint stf_id_pk primary key autoincrement,
    stf_name    text not null,
    stf_type    integer not null
);
            