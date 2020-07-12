-- Generated by Ora2Pg, the Oracle database Schema converter, version 20.0
-- Copyright 2000-2019 Gilles DAROLD. All rights reserved.
-- DATASOURCE: dbi:Oracle:host=oracle-poc.c6vtaznvhukg.ap-southeast-2.rds.amazonaws.com;sid=DATABASE;port=1521

SET client_encoding TO 'UTF8';

\set ON_ERROR_STOP ON

CREATE EXTENSION IF NOT EXISTS file_fdw;

CREATE SERVER bdump FOREIGN DATA WRAPPER file_fdw;


CREATE TABLE "acl$_obj" (
	name varchar(256) NOT NULL,
	id bigint NOT NULL
) ;
ALTER TABLE "acl$_obj" ADD UNIQUE (name);

CREATE TABLE exadirect_acl (
	service_name varchar(512) NOT NULL,
	vm_uuid varchar(34) NOT NULL,
	vm_sgid varchar(39)
) ;
ALTER TABLE exadirect_acl ADD UNIQUE (service_name,vm_uuid);

CREATE TABLE ip_acl (
	service_name varchar(512) NOT NULL,
	host varchar(256)
) ;
ALTER TABLE ip_acl ADD UNIQUE (service_name,host);

CREATE TABLE rds_configuration (
	name varchar(30) NOT NULL,
	value varchar(4000) NOT NULL,
	description varchar(4000)
) ;
ALTER TABLE rds_configuration ADD PRIMARY KEY (name);

CREATE TABLE rds_master_log (
	log_date timestamp NOT NULL,
	procedure_name varchar(30) NOT NULL,
	db_name varchar(9) NOT NULL,
	inst_id bigint NOT NULL,
	sid bigint NOT NULL,
	logon_time timestamp NOT NULL,
	username varchar(30) NOT NULL,
	osuser varchar(30) NOT NULL,
	machine varchar(64) NOT NULL,
	module varchar(64) NOT NULL
) ;

CREATE TABLE rds_sys_privs (
	privilege varchar(40) NOT NULL,
	revoke_from_public varchar(1) NOT NULL DEFAULT 'Y',
	revoke_from_all_users varchar(1) NOT NULL DEFAULT 'Y',
	grant_to_public varchar(1) NOT NULL DEFAULT 'N',
	grant_to_master_user varchar(1) NOT NULL DEFAULT 'N',
	include_with_admin_option varchar(1) NOT NULL DEFAULT 'N',
	creation_date timestamp NOT NULL DEFAULT LOCALTIMESTAMP
) ;
ALTER TABLE rds_sys_privs ADD PRIMARY KEY (privilege);
ALTER TABLE rds_sys_privs ADD CONSTRAINT ck_rsp_grt_to_public CHECK (grant_to_public IN ('Y','N'));
ALTER TABLE rds_sys_privs ADD CONSTRAINT ck_rsp_rvk_from_all_users CHECK (revoke_from_all_users IN ('Y','N'));
ALTER TABLE rds_sys_privs ADD CONSTRAINT ck_rsp_grt_to_master_user CHECK (grant_to_master_user IN ('Y','N'));
ALTER TABLE rds_sys_privs ADD CONSTRAINT ck_rsp_rvk_from_public CHECK (revoke_from_public IN ('Y','N'));
ALTER TABLE rds_sys_privs ADD CONSTRAINT ck_rsp_inc_with_admin_option CHECK (include_with_admin_option IN ('Y','N'));

CREATE TABLE test_table (
	id bigint,
	presenter varchar(100)
) ;

CREATE FOREIGN TABLE tracefile_listing (
	filename varchar(400),
	type varchar(12),
	filesize bigint,
	mtime varchar(400)
) SERVER bdump OPTIONS(filename 'DISABLED', format 'csv', delimiter ',');