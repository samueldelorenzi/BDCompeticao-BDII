drop database if exists bd_competicao;

create database bd_competicao;

use bd_competicao;

create table modalidade (
    id_modalidade int primary key,
    nome_modalidade varchar(255),
    tipo enum('Individual', 'Equipe')
);

create table equipe (
    id_equipe int primary key,
    nome_equipe varchar(255),
    pais_origem varchar(255),
    id_modalidade int,
    foreign key (id_modalidade) references modalidade(id_modalidade)
);

create table atleta (
    id_atleta int primary key,
    nome varchar(255),
    idade int,
    genero char(1),
    pais_origem varchar(255),
    id_modalidade int,
    id_equipe int, 
	foreign key (id_modalidade) references modalidade(id_modalidade),
    foreign key (id_equipe) references equipe(id_equipe)
);

create table torneio (
    id_torneio int primary key,
    nome_torneio varchar(255),
    data_inicio date,
    data_fim date,
    formato enum('Grupos', 'Pontos Corridos')
);

create table fase_torneio (
    id_fase int primary key,
    nome_fase varchar(255),
    id_torneio int,
    foreign key (id_torneio) references torneio(id_torneio)
);

create table grupo (
    id_grupo int primary key,
    nome_grupo varchar(255),
    id_fase int,
    foreign key (id_fase) references fase_torneio(id_fase)
);

create table participacao (
    id_participacao int primary key,
    id_torneio int,
    id_fase int,
    id_grupo int null,
    id_atleta int null,
    id_equipe int null,
    pontos_acumulados int,
    foreign key (id_torneio) references torneio(id_torneio),
    foreign key (id_fase) references fase_torneio(id_fase),
    foreign key (id_grupo) references grupo(id_grupo),
    foreign key (id_atleta) references atleta(id_atleta),
    foreign key (id_equipe) references equipe(id_equipe)
);

create table pontuacao (
    id_pontuacao int primary key,
    id_grupo int,
    id_atleta int null,
    id_equipe int null,
    pontos_total int,
    foreign key (id_grupo) references grupo(id_grupo),
    foreign key (id_atleta) references atleta(id_atleta),
    foreign key (id_equipe) references equipe(id_equipe)
);

create table partida (
    id_partida int primary key,
    data_partida datetime,
    id_grupo int null,
    id_fase int,
    id_equipe1 int,
    id_equipe2 int,
    id_atleta1 int,
    id_atleta2 int,
    pontos_oponente1 int,
    pontos_oponente2 int,
    id_equipe_vencedora int,
    id_atleta_vencedor int,
    foreign key (id_grupo) references grupo(id_grupo),
    foreign key (id_fase) references fase_torneio(id_fase),
    foreign key (id_equipe1) references equipe(id_equipe),
    foreign key (id_equipe2) references equipe(id_equipe),
    foreign key (id_atleta1) references atleta(id_atleta),
    foreign key (id_atleta2) references atleta(id_atleta),
    foreign key (id_atleta_vencedor) references atleta(id_atleta),
    foreign key (id_equipe_vencedora) references equipe(id_equipe)
);