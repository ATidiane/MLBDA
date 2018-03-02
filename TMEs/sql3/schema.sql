-- compléter l'entête 
-- ==================

-- NOM    : BEN MOUSSA
-- Prénom : Fakhri

-- NOM    : BALDE
-- Prénom : Ahmed Tidiane

-- Groupe :
-- binome :

-- ================================================

set sqlbl on


-- nettoyer le compte
@vider

-- Définition des types de données

prompt essai

create type T_un_type as object (
 un_attribut Number
);
@compile

create type pieces as Object (
       nom varchar2(20)
) not final;
@compile

create type matiere as Object (
       nom varchar2(20),
       prix number(5),
       masse_volumique number(10)
);
@compile

create type Pbase under pieces (
       mat ref matiere
) not final;
@compile

create type ens_pieces as table of ref pieces;
@compile

create type composite under pieces (
       cout_assemblage number(10),
       ensPieces ens_pieces,
       quantite number(5)
);
@compile

create type cubique under Pbase (
       cote number(5)
);
@compile

create type sphere under Pbase (
       rayon number(5)
);
@compile

create type parall under Pbase (
       longueur number(5),
       largeur number(5),
       hauteur number(5)
);
@compile

create type cylindre under Pbase (
       rayon number(5),
       hauteur number(5)
);
@compile

create type ens_cylindre as table of ref cylindre;
@compile

create table LesMatiere of matiere;
@compile

create table LesPBase of Pbase;
@compile

--insert into LesMatiere values (matiere('bois', 10, 2));
--insert into LesMatiere values (matiere('fer', 5, 3));
--insert into LesMatiere values (matiere('ferrite', 6, 10));
--create or replace Procedure test as tableBois ref matiere;
--begin
--select ref(m) into tableBois from LesMatiere m where m.nom = 'bois';
--end;

--insert into LesPBase values(cylindre('canne',(select ref(m) from LesMatiere m where m.nom = 'bois'), 2, 30));
--insert into LesPBase values(parall('plateau',(select ref(m) from LesMatiere m where m.nom = 'bois'), 1, 100 , 80));     
--insert into LesPBase values(sphere('boule',(select ref(m) from LesMatiere m where m.nom = 'fer'),30));
--insert into LesPBase values(sphere('pied',(select ref(m) from LesMatiere m where m.nom = 'bois') ,30));
--insert into LesPBase values(cylindre('clou',(select ref(m) from LesMatiere m where m.nom = 'fer'), 1, 20));
--insert into LesPBase values(cylindre('aimant',(select ref(m) from LesMatiere m where m.nom = 'ferrite'), 2, 5));


--insert into LesMatiere values (matiere('bois', 10, 2));
--insert into LesMatiere values (matiere('fer', 5, 3));
--insert into LesMatiere values (matiere('ferrite', 6, 10));
--create or replace Procedure test as tableBois ref matiere;
--begin
--select ref(m) into tableBois from LesMatiere m where m.nom = 'bois';
--end;

--insert into LesPBase values(cylindre('canne',(select ref(m) from LesMatiere m where m.nom = 'bois'), 2, 30));
--insert into LesPBase values(parall('plateau',(select ref(m) from LesMatiere m where m.nom = 'bois'), 1, 100 , 80));     
--insert into LesPBase values(sphere('boule',(select ref(m) from LesMatiere m where m.nom = 'fer'),30));
--insert into LesPBase values(sphere('pied',(select ref(m) from LesMatiere m where m.nom = 'bois') ,30));
--insert into LesPBase values(cylindre('clou',(select ref(m) from LesMatiere m where m.nom = 'fer'), 1, 20));
--insert into LesPBase values(cylindre('aimant',(select ref(m) from LesMatiere m where m.nom = 'ferrite'), 2, 5));

create table LesPComposites of composite
nested table ensPieces store as ntt_EnsPieces;
@compile

insert into LesPComposites values( composite('table', 100,
                         ens_pieces((select ref(b) from LesPBase b where b.nom = 'plateau'),
                                    (select ref(b) from LesPBase b where b.nom = 'pied'),
                                    (select ref(b) from LesPBase b where b.nom = 'pied'),
                                    (select ref(b) from LesPBase b where b.nom = 'pied'),
                                    (select ref(b) from LesPBase b where b.nom = 'pied'),
                                    (select ref(b) from LesPBase b where b.nom = 'clou'),
                                    (select ref(b) from LesPBase b where b.nom = 'clou'),
                                    (select ref(b) from LesPBase b where b.nom = 'clou'),
                                    (select ref(b) from LesPBase b where b.nom = 'clou'),
                                    (select ref(b) from LesPBase b where b.nom = 'clou'),
                                    (select ref(b) from LesPBase b where b.nom = 'clou'),
                                    (select ref(b) from LesPBase b where b.nom = 'clou'),
                                    (select ref(b) from LesPBase b where b.nom = 'clou'),
                                    (select ref(b) from LesPBase b where b.nom = 'clou'),
                                    (select ref(b) from LesPBase b where b.nom = 'clou'),
                                    (select ref(b) from LesPBase b where b.nom = 'clou'),
                                    (select ref(b) from LesPBase b where b.nom = 'clou')
                                    ),
                                    1));

insert into LesPComposites values(Composite('billard', 10,
                                    ens_pieces((select ref(b) from LesPComposites b where b.nom = 'table'),
                                    (select ref(b) from LesPBase b where b.nom = 'boule'),
                                    (select ref(b) from LesPBase b where b.nom = 'boule'),
                                    (select ref(b) from LesPBase b where b.nom = 'boule'),
                                    (select ref(b) from LesPBase b where b.nom = 'canne'),
                                    (select ref(b) from LesPBase b where b.nom = 'canne')
                                    ),
                                    1));

                                       
                
create or replace Procedure test as tableBois ref matiere;
--begin
--select ref(m) into tableBois from LesMatiere m where m.nom = 'bois';
--end;


select m.nom, m.prix from LesMatiere m;
select m.nom from LesMatiere m where m.prix<=5 ;
select value(b) from LesPBase b where deref(b.mat).nom = 'bois' ;
select m.nom from LesMatiere m where m.nom like '%fer%';
select distinct(value(p).nom) from LesPComposites c, table(c.ensPieces) p where c.nom = 'billard';
select c.nom, count(value(p)) from LesPComposites c, table(c.ensPieces) p group by c.nom;
select c.nom  from LesPComposites c, table(c.ensPieces) p group by c.nom
having count(value(p)) >= 3;

-- liste de tous les types créés
@liste


