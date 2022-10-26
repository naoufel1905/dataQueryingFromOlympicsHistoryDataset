select distinct goldcount.games,goldcount.region,gold,silvercount.region,silver,bronzecount.region,bronze from
(select t1.* 
from (select games,region,count(medal) as gold from olympics_history,olympics_history_noc_regions
where
medal='Gold' and 
olympics_history.noc=olympics_history_noc_regions.noc 
group by games,region
order by count(medal) desc ) as t1 inner join 
(select games,max(gold) as maxnbgold from
(select games,region,count(medal) as gold from olympics_history,olympics_history_noc_regions
where
medal='Gold' and 
 
olympics_history.noc=olympics_history_noc_regions.noc 
group by games,region
order by count(medal) desc  ) as t1
group by games) as t2
on t1.games=t2.games and t2.maxnbgold=t1.gold
order by games ) as goldcount ,



(select t1.* 
from (select games,region,count(medal) as silver from olympics_history,olympics_history_noc_regions
where
medal='Silver' and 
olympics_history.noc=olympics_history_noc_regions.noc 
group by games,region
order by count(medal) desc ) as t1 inner join 
(select games,max(silver) as maxnbgold from
(select games,region,count(medal) as silver from olympics_history,olympics_history_noc_regions
where
medal='Silver' and 
 
olympics_history.noc=olympics_history_noc_regions.noc 
group by games,region
order by count(medal) desc  ) as t1
group by games) as t2
on t1.games=t2.games and t2.maxnbgold=t1.silver
order by games) as silvercount ,




(select t1.* 
from (select games,region,count(medal) as bronze from olympics_history,olympics_history_noc_regions
where
medal='Bronze' and 
olympics_history.noc=olympics_history_noc_regions.noc 
group by games,region
order by count(medal) desc ) as t1 inner join 
(select games,max(bronze) as maxnbgold from
(select games,region,count(medal) as bronze from olympics_history,olympics_history_noc_regions
where
medal='Bronze' and 
 
olympics_history.noc=olympics_history_noc_regions.noc 
group by games,region
order by count(medal) desc  ) as t1
group by games) as t2
on t1.games=t2.games and t2.maxnbgold=t1.bronze
order by games) as bronzecount

where goldcount.games=silvercount.games and silvercount.games=bronzecount.games
