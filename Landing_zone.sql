
create table GAMES
(
    game_id                int          not null
        primary key,
    competition_id         varchar(5)   null,
    season                 int          null,
    round                  varchar(20)  null,
    date                   date         null,
    home_club_id           int          null,
    away_club_id           int          null,
    home_club_goals        int          null,
    away_club_goals        int          null,
    home_club_manager_name varchar(50)  null,
    stadium                varchar(50)  null,
    attendance             int          null,
    home_club_name         varchar(250) null,
    away_club_name         varchar(250) null,
    aggregate              varchar(20)  null,
    competition_type       varchar(40)  null
);

create table GAME_EVENTS
(
    game_event_id varchar(50) not null
        primary key,
    date          text        null,
    game_id       int         null,
    minute        int         null,
    type          text        null,
    club_id       int         null,
    player_id     int         null,
    description   text        null,
    player_in_id  int         null
);

create table PLAYERS
(
    player_id                            int  not null
        primary key,
    first_name                           text null,
    last_name                            text null,
    last_season                          int  null,
    current_club_id                      int  null,
    player_code                          text null,
    country_of_citizenship               text null,
    date_of_birth                        text null,
    position                             text null,
    foot                                 text null,
    current_club_domestic_competition_id text null,
    current_club_name                    text null
);
