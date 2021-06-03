/**
   PRIV_TYPES   权限类型 SELECT,UPDATE  用,分割
   SRC_USER   表归属用户
   DEST_USER 目标用户
    需求来源：
    测试库，我想将使用的用户分为两部分：
    1.更新数据用户。 这部分用户有增删改查权限。
    2.查询用户。  这部分用户只有查询权限。可以自己新建表和存储过程开发程序。但是不能对已有数据进行修改。

   调用示例:
    declare
    begin
       --调用存储过程---
       TOOL_GRANT_PRIV('SELECT','HS_USER','HS_QUERY');
    end;
 */
create or replace procedure TOOL_GRANT_PRIV(PRIV_TYPES in varchar2,SRC_USER in VARCHAR2,DEST_USER in varchar2) authid current_user is
v_table dba_tables%rowtype;
v_sql varchar2(1000);
begin

for v_table in (select  t.* from dba_tables t where t.OWNER = SRC_USER  ) loop
v_sql:= 'grant '|| PRIV_TYPES||' on '||v_table.owner||'.'||v_table.table_name||' to '|| DEST_USER;
execute immediate  v_sql;
dbms_output.put_line(v_sql);
end loop;

end TOOL_GRANT_PRIV;
