-- ----------------------------
-- 1、日志详情表
-- ----------------------------
drop table if exists ops_log_detail;
create table ops_log_detail
(
    log_id      bigint(20) 	not null auto_increment comment '日志id',
    src_id      varchar(36) default null comment '日志来源id',
    src_type    char(1)     default '0' comment '来源类型（0代表文件导入 1代表ES导入）',
    x_id        varchar(36) not null comment '链路id',
    parent_x_id varchar(36) default null comment '父链路id',
    coordinate  varchar(36) default null comment '坐标',
    occur_time  datetime    default null comment '日志发生时间',
    host_name   varchar(20) default '' comment '主机名',
    log_level   char(1)     default '0' comment '日志级别（0代表TRACE 1代表DEBUG 2代表INFO 3代表WARN 4代表ERROR 5代表FATAL）',
    content     longtext    default null comment '日志内容',
    content_ext longtext    default null comment '扩展内容',
    create_by   varchar(64) default '' comment '创建者',
    create_time datetime    default null comment '创建时间',
    update_by   varchar(64) default '' comment '更新者',
    update_time datetime    default null comment '更新时间',
    primary key (log_id),
    -- 联合唯一索引：src_id & src_type
    unique key uk_src_id_src_type (src_id, src_type)
) engine = innodb comment = '日志详情表';

-- ----------------------------
-- 2、日志分析表
-- ----------------------------
drop table if exists ops_log_analysis;
create table ops_log_analysis
(
    analysis_id    bigint(20)  not null auto_increment 		comment '分析id',
    x_id           varchar(36) not null comment '链路id',
    host_name      varchar(20) default '' comment '主机名',
    analysis_level char(1)     default '0' comment '分析级别（0代表忽略 1代表低危 2代表中危 3代表高危 4代表致命）',
    analysis_type  char(1)     default '0' comment '分析类型（0代表待分析 1代表待修复 2代表待部署 3代表已修复 4代表无需修复 5代表误报）',
    temp_result    longtext    default null comment '临时结果',
    final_result   longtext    default null comment '最终结果',
    end_time       datetime    default null comment '日志结束时间',
    x_cost         bigint(13)  default null	comment '链路用时',
    create_by      varchar(64) default '' comment '创建者',
    create_time    datetime    default null comment '创建时间',
    update_by      varchar(64) default '' comment '更新者',
    update_time    datetime    default null comment '更新时间',
    primary key (analysis_id),
    unique (x_id)
) engine = innodb comment = '日志分析表';
-- ----------------------------
-- 3、日志正则表
-- ----------------------------
drop table if exists ops_log_regex;
create table ops_log_regex
(
    regex_id    bigint(20)  not null auto_increment comment '正则id',
    application char(1)     default '0' comment '应用（于哪个产品）',
    name        varchar(20) default '' comment '名称',
    expression  longtext    default null comment '表达式',
    create_by   varchar(64) default '' comment '创建者',
    create_time datetime    default null comment '创建时间',
    update_by   varchar(64) default '' comment '更新者',
    update_time datetime    default null comment '更新时间',
    primary key (regex_id),
    -- 联合唯一索引：application & name
    unique key uk_application_name (application, name)
) engine = innodb comment = '日志正则表';

-- ----------------------------
-- 4、日志环境映射表
-- ----------------------------
drop table if exists ops_log_env;
create table ops_log_env
(
    env_id      bigint(20)  not null auto_increment comment '环境id',
    host_name   varchar(20) default '' comment '主机名',
    name        varchar(20) default '' comment '名称',
    create_by   varchar(64) default '' comment '创建者',
    create_time datetime    default null comment '创建时间',
    update_by   varchar(64) default '' comment '更新者',
    update_time datetime    default null comment '更新时间',
    primary key (regex_id),
    unique (host_name)
) engine = innodb comment = '日志环境映射表';

-- ----------------------------
-- 5、日志源表 TBC
-- ----------------------------
drop table if exists ops_log_source;
create table ops_log_source
(
    source_id   bigint(20) 	not null auto_increment comment '来源id',
    host_name   varchar(20) default '' comment '主机名',
    name        varchar(20) default '' comment '名称',
    create_by   varchar(64) default '' comment '创建者',
    create_time datetime    default null comment '创建时间',
    update_by   varchar(64) default '' comment '更新者',
    update_time datetime    default null comment '更新时间',
    primary key (regex_id),
    unique (host_name)
) engine = innodb comment = '日志源表';
-- ----------------------------
-- 6、数据库配置表
-- ----------------------------
drop table if exists ops_database_config;
create table ops_database_config
(
    config_id   bigint(20)  not null auto_increment comment '配置id',
    name        varchar(20) default '' comment '名称',
    class       varchar(72) default '' comment '类别',
    host        varchar(36) default '' comment '服务器地址',
    port        int(5)		default 0  comment '端口',
    database    varchar(20) default '' comment '数据库',
    username    varchar(36) default '' comment '用户名',
    password    varchar(36) default '' comment '密码',
    create_by   varchar(64) default '' comment '创建者',
    create_time datetime    default null comment '创建时间',
    update_by   varchar(64) default '' comment '更新者',
    update_time datetime    default null comment '更新时间',
    primary key (config_id),
    unique (name)
) engine = innodb comment = '数据库配置表';

-- ----------------------------
-- 7、业务接口表
-- ----------------------------

-- ----------------------------
-- 8、业务接口请求历史记录表
-- ----------------------------
