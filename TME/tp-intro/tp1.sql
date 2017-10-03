-- MABD TP1 SQL avec la base MONDIAL


-- -------------------- binome -------------------------
-- NOM  BALDE
-- Prenom Ahmed Tidiane

-- NOM BEN MOUSSA
-- Prenom Fakhri
-- -----------------------------------------------------

-- pour se connecter à oracle:
-- sqlplus E1234567/E1234567@oracle
-- remplacer E12345657 par la lettre E suivie de votre numéro de login

set sqlbl on
set linesize 150

prompt schema de la table Country
desc Country

prompt schema de la table City
desc City

prompt schema de la table IsMember
desc IsMember

prompt schema de la table City
desc City

-- pour afficher un nuplet entier sur une seule ligne
column name format A15
column capital format A15
column province format A20

-- Requete 0

select * from mondial.Country c where c.name = 'France';
select * from mondial.Continent;
-- Requete 1
prompt 

--8
select c.name, sum(c.population)
from mondial.borders b, mondial.country c
where c.code = b.country1 or c.code = b.country2
group by c.code, c.name;

--9
select c.name, sum(c.population)
from mondial.borders b, mondial.country c , mondial.Encompasses e
where (c.code = b.country1 or c.code = b.country2) and e.continent = 'Europe' and e.Country = c.Code
group by c.code, c.name;

--12
select c.name, m.name, m.height
from mondial.Geo_mountain g, mondial.Mountain m, mondial.Encompasses e, mondial.Country c
where m.name = g.mountain and g.country = c.code and e.country = c.code and e.continent = 'America'
group by c.code, c.name, m.name, m.height
having m.height >= (select MAX(m2.height) from mondial.Mountain m2, mondial.Geo_Mountain g2 where g2.country = c.code and m2.name = g2.mountain);

--13
select r.name
from mondial.River r where r.River='Nile';

--14

select g.name
from mondial.River g
where g.River IN (
select r.name
from mondial.River r where r.River='Nile'))
union
(select r2.name
from mondial.River r2 where r2.River='Nile');

--15
select sum(r.length)
from mondial.River r
where r.River = 'Nile' or r.name = 'Nile';

--16a
select o.abbreviation, COUNT(*) as somme
from mondial.organization o, mondial.country c, mondial.IsMember i
where c.code=i.country and i.organization = o.abbreviation
group by o.abbreviation
having Count(*) >= ALL (select COUNT(*)
from mondial.organization o2, mondial.country c2, mondial.IsMember i2
where c2.code=i2.country and i2.organization = o2.abbreviation
group by o2.abbreviation);

--16b
select * from 
(select o.abbreviation, COUNT(*) as somme
from mondial.organization o, mondial.country c, mondial.IsMember i
where c.code=i.country and i.organization = o.abbreviation
group by o.abbreviation
order by somme desc) where rownum <= 3;






-- Requete 2
prompt 
