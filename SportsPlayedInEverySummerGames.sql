select count(sport),sport
from ( select distinct(sport), year,games
from olympics_history o
where season ='Summer'
and exists (select 1 from ( select distinct sport,year
from olympics_history h
where  h.season ='Summer' ) as sportstable
where o.sport=sportstable.sport and o.year=sportstable.year
		   )
order by year) as mainresult 
group by sport
having count(sport)=29