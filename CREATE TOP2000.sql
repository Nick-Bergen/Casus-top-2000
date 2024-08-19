/*==============================================================*/
/* DBMS name:      Microsoft SQL Server 2014                    */
/* Created on:     28-9-2021 14:35:09                           */
/*==============================================================*/


create rule R_DURATION as
      @column >= '0'
go

create rule R_LINEUPYEAR as
      @column >= '1999'
go

create rule R_POSITION as
      @column >= 1
go

create rule R_SEX as
      @column in ('M','F','X')
go

create rule R_TOP2000POSITION as
      @column between 1 and 2000
go

create rule R_WEEKSINLIST as
      @column >= 1
go

/*==============================================================*/
/* Table: BAND                                                  */
/*==============================================================*/
create table BAND (
   BANDNAME             varchar(255)         not null,
   YEARCREATED          datetime             not null,
   LOCATIONCREATED      varchar(255)         null,
   YEARDISBANDED        datetime             null,
   constraint PK_BAND primary key (BANDNAME)
)
go

/*==============================================================*/
/* Table: BANDMEMBER                                            */
/*==============================================================*/
create table BANDMEMBER (
   FIRSTNAME            varchar(255)         not null,
   LASTNAME             varchar(255)         not null,
   BIRTHDATE            datetime             not null,
   DATE_OF_DEATH        datetime             null,
   constraint PK_BANDMEMBER primary key (FIRSTNAME, LASTNAME)
)
go

/*==============================================================*/
/* Table: CITY                                                  */
/*==============================================================*/
create table CITY (
   CITYNAME             varchar(255)         not null,
   TOWNSHIPNAME         varchar(255)         not null,
   constraint PK_CITY primary key (CITYNAME)
)
go

/*==============================================================*/
/* Table: COLLABORATION_ARTIST                                  */
/*==============================================================*/
create table COLLABORATION_ARTIST (
   MAINBAND             varchar(255)         not null,
   TITLE                varchar(255)         not null,
   COLLABORATIONBAND    varchar(255)         not null,
   constraint PK_COLLABORATION_ARTIST primary key (MAINBAND, TITLE, COLLABORATIONBAND)
)
go

/*==============================================================*/
/* Table: COMPONIST                                             */
/*==============================================================*/
create table COMPONIST (
   NAME                 varchar(255)         not null,
   constraint PK_COMPONIST primary key (NAME)
)
go

/*==============================================================*/
/* Table: COMPONIST_IN_SONG                                     */
/*==============================================================*/
create table COMPONIST_IN_SONG (
   BANDNAME             varchar(255)         not null,
   TITLE                varchar(255)         not null,
   NAME                 varchar(255)         not null,
   constraint PK_COMPONIST_IN_SONG primary key (BANDNAME, TITLE, NAME)
)
go

/*==============================================================*/
/* Table: DJ                                                    */
/*==============================================================*/
create table DJ (
   FIRSTNAME            varchar(255)         not null,
   LASTNAME             varchar(255)         not null,
   constraint PK_DJ primary key (FIRSTNAME, LASTNAME)
)
go

/*==============================================================*/
/* Table: DJLINEUP                                              */
/*==============================================================*/
create table DJLINEUP (
   FIRSTNAME            varchar(255)         not null,
   LASTNAME             varchar(255)         not null,
   LINEUPYEAR           datetime             not null,
   STARTTIME            datetime             not null,
   ENDTIME              datetime             not null,
   constraint PK_DJLINEUP primary key (FIRSTNAME, LASTNAME, LINEUPYEAR, STARTTIME, ENDTIME)
)
go

alter table DJLINEUP
   add constraint CKC_LINEUPYEAR_DJLINEUP check (LINEUPYEAR >= '1999')
go

/*==============================================================*/
/* Table: GENRE                                                 */
/*==============================================================*/
create table GENRE (
   GENRE                varchar(255)         not null,
   constraint PK_GENRE primary key (GENRE)
)
go

/*==============================================================*/
/* Table: HITLISTS                                              */
/*==============================================================*/
create table HITLISTS (
   LISTNAME             varchar(255)         not null,
   constraint PK_HITLISTS primary key (LISTNAME)
)
go

/*==============================================================*/
/* Table: HITSCORES                                             */
/*==============================================================*/
create table HITSCORES (
   BANDNAME             varchar(255)         not null,
   TITLE                varchar(255)         not null,
   LISTNAME             varchar(255)         not null,
   HIGHESTPOSITION      int                  not null,
   WEEKSINLIST          smallint             not null,
   constraint PK_HITSCORES primary key (BANDNAME, TITLE, LISTNAME)
)
go

alter table HITSCORES
   add constraint CKC_HIGHESTPOSITION_HITSCORE check (HIGHESTPOSITION >= 1)
go

alter table HITSCORES
   add constraint CKC_WEEKSINLIST_HITSCORE check (WEEKSINLIST >= 1)
go

/*==============================================================*/
/* Table: MEMBER_IN_BAND                                        */
/*==============================================================*/
create table MEMBER_IN_BAND (
   FIRSTNAME            varchar(255)         not null,
   LASTNAME             varchar(255)         not null,
   BANDNAME             varchar(255)         not null,
   constraint PK_MEMBER_IN_BAND primary key (FIRSTNAME, LASTNAME, BANDNAME)
)
go

/*==============================================================*/
/* Table: PERSON                                                */
/*==============================================================*/
create table PERSON (
   FIRSTNAME            varchar(255)         not null,
   LASTNAME             varchar(255)         not null,
   constraint PK_PERSON primary key (FIRSTNAME, LASTNAME)
)
go

/*==============================================================*/
/* Table: POSTALCODE                                            */
/*==============================================================*/
create table POSTALCODE (
   POSTALCODE           varchar(10)          not null,
   CITYNAME             varchar(255)         not null,
   constraint PK_POSTALCODE primary key (POSTALCODE)
)
go

/*==============================================================*/
/* Table: SONG                                                  */
/*==============================================================*/
create table SONG (
   BANDNAME             varchar(255)         not null,
   TITLE                varchar(255)         not null,
   YEAR                 datetime             not null,
   DURATION             datetime             not null,
   STANDARDLIST         bit                  not null,
   SOURCE               varchar(255)         null,
   constraint PK_SONG primary key (BANDNAME, TITLE)
)
go

alter table SONG
   add constraint CKC_DURATION_SONG check (DURATION >= '0')
go

/*==============================================================*/
/* Table: SONG_IN_GENRE                                         */
/*==============================================================*/
create table SONG_IN_GENRE (
   GENRE                varchar(255)         not null,
   BANDNAME             varchar(255)         not null,
   TITLE                varchar(255)         not null,
   constraint PK_SONG_IN_GENRE primary key (BANDNAME, GENRE, TITLE)
)
go

/*==============================================================*/
/* Table: TOP2000ENTRY                                          */
/*==============================================================*/
create table TOP2000ENTRY (
   POSITION             int                  not null,
   TOP2000YEAR          datetime             not null,
   BANDNAME             varchar(255)         not null,
   TITLE                varchar(255)         not null,
   constraint PK_TOP2000ENTRY primary key (POSITION, TOP2000YEAR)
)
go

alter table TOP2000ENTRY
   add constraint CKC_POSITION_TOP2000E check (POSITION between 1 and 2000)
go

alter table TOP2000ENTRY
   add constraint CKC_TOP2000YEAR_TOP2000E check (TOP2000YEAR >= '1999')
go

/*==============================================================*/
/* Table: TOWNSHIP                                              */
/*==============================================================*/
create table TOWNSHIP (
   TOWNSHIPNAME         varchar(255)         not null,
   constraint PK_TOWNSHIP primary key (TOWNSHIPNAME)
)
go

/*==============================================================*/
/* Table: VOTER                                                 */
/*==============================================================*/
create table VOTER (
   EMAIL                varchar(255)         not null,
   POSTALCODE           varchar(10)          not null,
   SEX                  char(1)              not null,
   AGECATEGORY          varchar(255)         not null,
   constraint PK_VOTER primary key (EMAIL)
)
go

alter table VOTER
   add constraint CKC_SEX_VOTER check (SEX in ('M','F','X'))
go

alter table VOTER
   add constraint CKC_AGECATEGORY_VOTER check (AGECATEGORY between '1' and '150')
go

/*==============================================================*/
/* Table: VOTES                                                 */
/*==============================================================*/
create table VOTES (
   EMAIL                varchar(255)         not null,
   BANDNAME             varchar(255)         not null,
   TITLE                varchar(255)         not null,
   constraint PK_VOTES primary key (BANDNAME, EMAIL, TITLE)
)
go

alter table BANDMEMBER
   add constraint FK_BANDMEMB_IS_A_PERS_PERSON foreign key (FIRSTNAME, LASTNAME)
      references PERSON (FIRSTNAME, LASTNAME)
         on update cascade
go

alter table CITY
   add constraint FK_CITY_CITY_IN_T_TOWNSHIP foreign key (TOWNSHIPNAME)
      references TOWNSHIP (TOWNSHIPNAME)
         on update cascade
go

alter table COLLABORATION_ARTIST
   add constraint FK_COLLABOR_COLLABORA_SONG foreign key (MAINBAND, TITLE)
      references SONG (BANDNAME, TITLE)
         on delete cascade
go

alter table COLLABORATION_ARTIST
   add constraint FK_COLLABOR_COLLABORA_BAND foreign key (COLLABORATIONBAND)
      references BAND (BANDNAME)
         on update cascade on delete cascade
go

alter table COMPONIST_IN_SONG
   add constraint FK_COMPONIS_COMPONIST_SONG foreign key (BANDNAME, TITLE)
      references SONG (BANDNAME, TITLE)
         on update cascade on delete cascade
go

alter table COMPONIST_IN_SONG
   add constraint FK_COMPONIS_COMPONIST_COMPONIS foreign key (NAME)
      references COMPONIST (NAME)
         on update cascade on delete cascade
go

alter table DJ
   add constraint FK_DJ_IS_A_PERS_PERSON foreign key (FIRSTNAME, LASTNAME)
      references PERSON (FIRSTNAME, LASTNAME)
         on update cascade on delete cascade
go

alter table DJLINEUP
   add constraint FK_DJLINEUP_DJ_IN_LIN_DJ foreign key (FIRSTNAME, LASTNAME)
      references DJ (FIRSTNAME, LASTNAME)
         on update cascade on delete cascade
go

alter table HITSCORES
   add constraint FK_HITSCORE_HITSCORE__HITLISTS foreign key (LISTNAME)
      references HITLISTS (LISTNAME)
         on update cascade on delete cascade
go

alter table HITSCORES
   add constraint FK_HITSCORE_SONG_IN_H_SONG foreign key (BANDNAME, TITLE)
      references SONG (BANDNAME, TITLE)
         on update cascade
go

alter table MEMBER_IN_BAND
   add constraint FK_MEMBER_I_MEMBER_IN_BANDMEMB foreign key (FIRSTNAME, LASTNAME)
      references BANDMEMBER (FIRSTNAME, LASTNAME)
         on update cascade
go

alter table MEMBER_IN_BAND
   add constraint FK_MEMBER_I_MEMBER_IN_BAND foreign key (BANDNAME)
      references BAND (BANDNAME)
         on update cascade on delete cascade
go

alter table POSTALCODE
   add constraint FK_POSTALCO_POSTALCOD_CITY foreign key (CITYNAME)
      references CITY (CITYNAME)
         on update cascade
go

alter table SONG
   add constraint FK_SONG_SONGARTIS_BAND foreign key (BANDNAME)
      references BAND (BANDNAME)
         on update cascade
go

alter table SONG_IN_GENRE
   add constraint FK_SONG_IN__SONG_IN_G_GENRE foreign key (GENRE)
      references GENRE (GENRE)
         on update cascade on delete cascade
go

alter table SONG_IN_GENRE
   add constraint FK_SONG_IN__SONG_IN_G_SONG foreign key (BANDNAME, TITLE)
      references SONG (BANDNAME, TITLE)
         on update cascade on delete cascade
go

alter table TOP2000ENTRY
   add constraint FK_TOP2000E_SONG_IN_T_SONG foreign key (BANDNAME, TITLE)
      references SONG (BANDNAME, TITLE)
         on update cascade
go

alter table VOTER
   add constraint FK_VOTER_PERSON_IN_POSTALCO foreign key (POSTALCODE)
      references POSTALCODE (POSTALCODE)
         on update cascade
go

alter table VOTES
   add constraint FK_VOTES_VOTED_FOR_VOTER foreign key (EMAIL)
      references VOTER (EMAIL)
         on update cascade on delete cascade
go

alter table VOTES
   add constraint FK_VOTES_VOTES_FOR_SONG foreign key (BANDNAME, TITLE)
      references SONG (BANDNAME, TITLE)
         on update cascade on delete cascade
go

