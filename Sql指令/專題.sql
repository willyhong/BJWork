/*專題*/
/*複合主鍵 有問題*/
drop database BJWORK95;
create database BJWORK95;
use  BJWORK95;

create table users
(
    user_id int(11) NOT NULL,
    u_photo nvarchar(100) unique,
    u_name nvarchar(50) NOT NULL,
    u_password nvarchar(50) NOT NULL,
    u_email nvarchar(50) NOT NULL,
    u_birth date NOT NULL,
    u_sex boolean NOT NULL,
    primary key(user_id)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*運動種類*/
CREATE TABLE sport_type (

  type_id int(11) NOT NULL,
  sport_id int(11) NOT NULL,
  sport_name varchar(45) NOT NULL,
  PRIMARY KEY (sport_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*設定*/
CREATE TABLE user_set (
  userset_num int(11) NOT NULL AUTO_INCREMENT,
  user_id int(9) NOT NULL,
  drink_set tinyint(1) NOT NULL,
  fight_set tinyint(1) NOT NULL,
  encourage_set tinyint(1) NOT NULL,
  PRIMARY KEY (userset_num),
  FOREIGN KEY (user_id) REFERENCES users (user_id) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*用戶健康資訊*/
CREATE TABLE user_health (
  user_health_num int(11) NOT NULL AUTO_INCREMENT,
  user_id int(11) NOT NULL,
  Height double NOT NULL,
  Weight double NOT NULL,
  dates  datetime NOT NULL,
  PRIMARY KEY (user_health_num),
  FOREIGN KEY (user_id) REFERENCES users (user_id)ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;




/*個人運動紀錄*/

CREATE TABLE pb (
  pbnum int(11) NOT NULL AUTO_INCREMENT,
  user_id int(11) NOT NULL,
  sport_id int(11) NOT NULL,
  distance double DEFAULT NULL,
  sets int(11) DEFAULT NULL,
  reps int(11) DEFAULT NULL,
  times time(3) NOT NULL,
  calories double NOT NULL,
  dates datetime(6) NOT NULL,
  PRIMARY KEY (pbnum),
  
  FOREIGN KEY (user_id) REFERENCES users ( user_id )ON UPDATE CASCADE,
  FOREIGN KEY (sport_id)  REFERENCES sport_type ( sport_id )ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;





/*自訂訓練菜單*/
CREATE TABLE personal_sport_menu (
  P_Menu_Num int(11) NOT NULL AUTO_INCREMENT,
  user_id int(11) NOT NULL,
  spdate date NOT NULL,
  sport_id int(11) NOT NULL,
  distance double DEFAULT NULL,
  sets int(11) DEFAULT NULL,
  reps int(11) DEFAULT NULL,
  times time(3) NOT NULL,
  finish bit(1) NOT NULL,
  PRIMARY KEY (p_menu_num),
  FOREIGN KEY (user_id)REFERENCES users (user_id) ON UPDATE CASCADE,
  FOREIGN KEY (sport_id)REFERENCES sport_type (sport_id) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



/*訓練強度*/

CREATE TABLE tranning_strong (
  strong_num int(11) NOT NULL,
  type_name varchar(45) NOT NULL,
  PRIMARY KEY (strong_num)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*系統規畫菜單*/
CREATE TABLE system_menu (
  system_menu_num int(11)auto_increment,
  strong_num int(11) NOT NULL,
  days_num int(11) NOT NULL,
  sport_id int(11) NOT NULL,
  distance double DEFAULT NULL,
  sets int(11) DEFAULT NULL,
  reps int(11) DEFAULT NULL,
  times time(3) NOT NULL,
  PRIMARY KEY (system_menu_num), 
  FOREIGN KEY (strong_num) REFERENCES tranning_strong ( strong_num ) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


/*系統規劃明細*/
CREATE TABLE systemcreateMenu (
  system_num int(11) NOT NULL AUTO_INCREMENT,
  user_id int(11) NOT NULL,
  days_num int(11) NOT NULL,
  sp_date date NOT NULL,
  strong_num int(11) NOT NULL,
  finish bit(1) NOT NULL,
  PRIMARY KEY (system_num),
  FOREIGN KEY (strong_num) REFERENCES system_menu ( strong_num ) ON UPDATE CASCADE,
  FOREIGN KEY (user_id) REFERENCES users ( user_id ) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



/*商城*/

create table products_class
(
	products_class_id int,
    products_class_name nvarchar(50) not null,
    primary key (products_class_id)
);

create table products
(
	products_id int,
    products_class_id int,
    products_name nvarchar(50) not null,
    jinx int not null,
    primary key (products_id),
    foreign key (products_class_id) references products_class(products_class_id)
);

create table order_details
(
	user_id int,
    products_id int,
    o_date date not null,
    primary key (user_id,products_id),
    foreign key (products_id) references products(products_id)
);
/*以下為成就*/

create table achievement
(
    ach_id int not null,
    sport_id int not null,
    user_id int not null,
    ach_name nvarchar(50) not null,
    reps int default null,
    calories double default null,
    distance double default null,
    primary key(ach_id),
    foreign key (sport_id) references sport_type(sport_id)
);

create table title
(
	title_id int not null ,
    ach_id int not null,
    title_name nvarchar(50) not null,
    primary key(title_id),
    foreign key(ach_id) references achievement(ach_id)
);

create table user_title
(
    user_title_num int,
	user_id int,
    title_id int,
    primary key(user_title_num),
    foreign key(user_id) references users(user_id),
    foreign key(title_id) references title(title_id)
);

create table user_ach
(
	user_id int,
    ach_id int,
    primary key(user_id,ach_id),
    foreign key(user_id) references users(user_id),
    foreign key(ach_id) references achievement(ach_id)
);
/*以下擂台*/
create table rings
(
	ring_id int,
    ring_name nvarchar(50),
    sport_id int,
    primary key(ring_id),
    foreign key(sport_id) references sport_type(sport_id)
);

create table ring_details
(
	ring_detail_num int,
    ring_id int,
    ring_user_id int,
    primary key(ring_detail_num),
    foreign key(ring_id) references rings(ring_id),
    foreign key(ring_user_id) references users(user_id)
);

create table ring_fight
(
	fight_num int,
    ring_id int,
    ring_user_id int,
    challenger_id int,
    ring_user_perform boolean,
    fight_date date,
    ginx int,
    primary key(fight_num),
    foreign key(ring_id) references rings(ring_id),
    foreign key(ring_user_id) references users(user_id),
    foreign key(challenger_id) references users(user_id)
);
/*競技場*/

create table stage
(
  stage_fight_num int not null auto_increment,
  stage_foreigner_id int not null,
  stage_challenged_id int not null,
  stage_foreigner_perform boolean,
  fight_date date,
  get_ranks int not null,
  primary key(stage_fight_num),
  foreign key(stage_foreigner_id)references users(user_id),
  foreign key(stage_challenged_id)references users(user_id)
);
/*用戶火柴人*/

create table user_m_men
(
  user_m_men_num int not null,
  user_m_men_id int(11) not null,
  user_total_ranks int ,
  user_fram_id int,
  user_back_id int,
  user_cover_photo nvarchar(100),
  user_title_id int,
  user_ginx int ,
  user_mmen_mode nvarchar(50),
  user_stronger_id int,
  user_atk int,
  user_def int,
  user_cri double,
  user_agi double,
  user_get_points int,
  primary key(user_m_men_num),
  foreign key(user_m_men_id)references users(user_id),
  foreign key(user_fram_id)references order_details(products_id),
  foreign key(user_back_id)references order_details(products_id),
  foreign key(user_cover_photo)references users(u_photo),
  foreign key(user_title_id)references user_title(title_id),
  foreign key(user_stronger_id)references sport_type(sport_id)
  
);






