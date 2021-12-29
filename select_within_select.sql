This tutorial looks at how we can use SELECT statements within SELECT statements to perform more complex queries.

name	continent	area	population	gdp
Afghanistan	Asia	652230	25500100	20343000000
Albania	Europe	28748	2831741	12960000000
Algeria	Africa	2381741	37100000	188681000000
Andorra	Europe	468	78115	3712000000
Angola	Africa	1246700	20609294	100990000000
...


1. List each country name where the population is larger than that of 'Russia'.
SELECT name FROM world
  WHERE population >
     (SELECT population FROM world
      WHERE name='Russia')

2.Show the countries in Europe with a per capita GDP greater than 'United Kingdom'.
select
name
from world
where gdp/population >
(select gdp/population
from world
where name = 'United Kingdom')
and continent = 'Europe'

3.List the name and continent of countries in the continents containing either Argentina or Australia. Order by name of the country.
select
name,
continent
from world
where continent in
(select continent
from world
where name in ('Argentina', 'Australia'))
order by name

4.Which country has a population that is more than Canada but less than Poland? Show the name and the population.
select
name,
population
from world
where population >
(select population
from world
where name = 'Canada')
and population <
(select population
from world
where name = 'Poland')

5. Show the name and the population of each country in Europe. Show the population as a percentage of the population of Germany.
select
name,
concat(round(population/(select population
from world
where name = 'Germany') *100, 0), '%') as percentage
from world
where continent = 'Europe'

We can use the word ALL to allow >= or > or < or <=to act over a list. For example, you can find the largest country in the world, by population with this query:

SELECT name
  FROM world
 WHERE population >= ALL(SELECT population
                           FROM world
                          WHERE population > 0)

6. Which countries have a GDP greater than every country in Europe? [Give the name only.] (Some countries may have NULL gdp values)
select
name
from world
where gdp > all(select gdp
from world
where gdp > 0 and continent = 'Europe')

7. Find the largest country (by area) in each continent, show the continent, the name and the area:
select
continent,
name,
area
from world x
where area >= all(select area
from world y
where y.continent = x.continent
and area > 0)

8. List each continent and the name of the country that comes first alphabetically.
select
x.continent,
x.name
from world x
where x.name <= all(select
y.name
from world y
where x.continent = y.continent)

9. Find the continents where all countries have a population <= 25000000. Then find the names of the countries associated with these continents. Show name, continent and population.
select
x.name,
x.continent,
x.population
from world x
where 25000000 >= all(select
y.population
from world y
where x.continent = y.continent
and y.population > 0)

10. Some countries have populations more than three times that of any of their neighbours (in the same continent). Give the countries and continents.
select
x.name,
x.continent
from world x
where x.population/3 > all(select
y.population
from world y
where x.continent = y.continent
and y.population > 0
and x.name <> y.name)
