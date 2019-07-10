drop database if exists PPost;
create database PPost;
use PPost;

create table ulvname(
    ulv tinyint primary key,
    ulvname char(16) not null
)engine=innodb,charset=utf8mb4;

create table user(
    uid               int primary key auto_increment,
    uname             char(16) not null unique,
    unickname         char(16) not null unique,
    upassword         char(32) not null,
    ulv               tinyint,
    uregtime          datetime,
    ulastlogintime    datetime,
    ulastloginip      varchar(64),
    ubirth            datetime,
    uage              tinyint unsigned,
    usex              boolean,
    uprovince         char(16),
    ucity             char(16),
    uarea             char(16),
    usignature        varchar(256),
    uhobby            varchar(64),
    umail             varchar(64),
    upagecount        tinyint unsigned,
    constraint fk_u_ulv foreign key (ulv) references ulvname(ulv)
         on delete restrict on update cascade
)engine=innodb,charset=utf8mb4;

create table post(
    pid int primary key auto_increment,
    uid int not null,
    ptitle varchar(64),
    pcontent varchar(256),
    ptime datetime,
    constraint fk_p_uid foreign key(uid) references user(uid)
        on delete cascade on update cascade,
    key(ptime),
    fulltext (ptitle, pcontent) with parser ngram
)engine=innodb, charset=utf8mb4;

create table comment(
    cid int primary key auto_increment,
    uid int not null,
    pid int not null,
    ccontent varchar(256),
    ctime datetime,
    constraint fk_c_uid foreign key(uid) references user(uid)
        on delete cascade on update cascade,
    constraint fk_c_pid foreign key(pid) references post(pid)
        on delete cascade on update cascade,
    key(uid),
    key(pid),
    fulltext (ccontent) with parser ngram
)engine=innodb, charset=utf8mb4;

create table suki(
    uid int,
    pid int,
    stime datetime,
    constraint fk_s_uid foreign key key(uid) references user(uid)
        on delete cascade on update cascade,
    constraint fk_s_pid foreign key key(pid) references post(pid)
        on delete cascade on update cascade,
    primary key(uid, pid)
)engine=innodb, charset=utf8mb4;

create table blacklist(
    blid     int primary key auto_increment,
    blip     varchar(64),
    bldate   datetime,
    key (blip)
)engine=innodb,charset=utf8mb4;

insert into ulvname values(-1, "警告");
insert into ulvname values(0, "是迷路的孩子呢");
insert into ulvname values(1, "是新来的P诶");
insert into ulvname values(2, "是来了有段时间的P的说");
insert into ulvname values(3, "是来好久的P了");
insert into ulvname values(4, "是P哦！");
insert into ulvname values(5, "是AdminP");
