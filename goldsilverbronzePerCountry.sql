select distinct(region),NbrGoldMedals,NbrSilverMedals,NbrBronzeMedals from
(select distinct(region),count(medal) as NbrGoldMedals
from (select region,medal
from olympics_history,olympics_history_noc_regions
where medal='Gold' and olympics_history_noc_regions.noc=olympics_history.noc) as table1
group by region
) as table11
 join  
(select distinct(region),count(medal) as NbrSilverMedals
from (select region,medal
from olympics_history,olympics_history_noc_regions
where medal='Silver' and olympics_history_noc_regions.noc=olympics_history.noc) as table1
group by distinct(region)
)  as table22 using (region) join 
(select region,count(medal) as NbrBronzeMedals
from (select region,medal
from olympics_history,olympics_history_noc_regions
where medal='Bronze' and olympics_history_noc_regions.noc=olympics_history.noc) as table1
group by distinct(region)
) as table33 using (region)
 order by NbrGoldMedals desc, NbrSilverMedals desc , NbrBronzeMedals desc