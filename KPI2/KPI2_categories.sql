select
	b.category
	,round(avg(a.stars),2) as avg_rating
	,count(distinct a.business_id) as nr_of_ratings
from business_main a
left join business_categories b
	on a.business_id = b.business_id
group by 1
order by 2 desc