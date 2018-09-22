CREATE DATABASE IF NOT exists p2p_blog CHARACTER SET 'utf8';
USE p2p_blog;

CREATE TABLE Categorie (
	id INT UNSIGNED AUTO_INCREMENT,
	nom VARCHAR(150) NOT NULL,
	description TEXT NOT NULL,
	PRIMARY KEY(id)
);

CREATE TABLE Categorie_article (
	categorie_id INT UNSIGNED,
	article_id INT UNSIGNED,
	PRIMARY KEY (categorie_id, article_id)
);

-- CREATION BASE DE DONNEES --

create table articles (
	id smallint unsigned not null auto_increment,
    titre varchar(100) not null,
    texte text not null,
    extrait text not null,
    date_publication datetime not null,
    primary key(id),
    index ind_date_publication (date_publication),
    unique index ind_uni_titre (titre)
)engine=INNODB;

create table utilisateurs (
	id smallint unsigned not null auto_increment,
	pseudo varchar(50) not null,
    email varchar(50) not null,
    mdp varchar(128) not null,
    unique index ind_uni_pseudo (pseudo),
    unique index ind_uni_email (email),
	primary key(id)
)engine=INNODB;

create table commentaires (
	id smallint unsigned not null auto_increment,
	texte text not null,
    article_id smallint unsigned not null,
    utilisateur_id smallint unsigned,
    constraint fk_commentaire_article_id foreign key (article_id) references articles(id) on delete cascade,
    constraint fk_commentaire_utilisateur_id foreign key (utilisateur_id) references utilisateurs(id) on delete cascade,
    primary key(id)
)engine=INNODB;

alter table articles
add column utilisateur_id smallint unsigned not null;

alter table articles
add constraint fk_articles_utilisateur_id foreign key (utilisateur_id) references utilisateurs(id) on delete cascade;

alter table Categorie
modify id smallint unsigned not null;

alter table Categorie_article
modify categorie_id smallint unsigned not null;

alter table Categorie_article
modify article_id smallint unsigned not null;

alter table Categorie_article
add constraint fk_categorie_article_categorie_id foreign key (categorie_id) references Categorie(id) on delete cascade;

alter table Categorie_article
add constraint fk_categorie_article_article_id foreign key (article_id) references articles(id) on delete cascade;

-- FIN CREATION BASE DE DONNEES --

-- PAGE ACCUEIL --
select articles.id, articles.titre, articles.extrait, articles.date_publication, utilisateurs.pseudo as user_pseudo
from articles
inner join utilisateurs
on articles.utilisateur_id = utilisateurs.id
order by articles.date_publication asc;

-- PAGE UTILISATEUR --
select utilisateurs.pseudo, utilisateurs.email, articles.titre, articles.texte, articles.date_publication
from utilisateurs
left join articles
on utilisateurs.id = articles.utilisateur_id
order by articles.date_publication asc;

-- PAGE CATEGORIE --
select Categorie.nom, Categorie.description, articles.texte, articles.date_publication
from Categorie
left join Categorie_article as intermediaire
on Categorie.id = intermediaire.categorie_id
inner join articles
on articles.id = intermediaire.article_id
order by articles.date_publication asc;

-- PAGE ARTICLE --
select articles.id, articles.titre, articles.texte, articles.date_publication, utilisateurs.pseudo as user_pseudo,
commentaires.texte as com_texte, user_commentaires.pseudo as user_com_pseudo
from articles

inner join utilisateurs
on articles.utilisateur_id = utilisateurs.id

left join commentaires
on articles.id = commentaires.article_id

left join utilisateurs as user_commentaires
on user_commentaires.id = commentaires.utilisateur_id

order by articles.date_publication asc;
