with cache_friends_per_user as 
	(select
		a.user_id
		,count(distinct b.friend) as nr_of_friends
	from user a
	left join user_friends b
		on a.user_id = b.user_id
	group by 1)
select
	'average number of friends' as measure
	,round(avg(nr_of_friends),2) as number
from cache_friends_per_user
UNION
select
	'average number of friends (none zero)' as measure
	,round(avg(nr_of_friends),2) as number
from cache_friends_per_user
where nr_of_friends > 0