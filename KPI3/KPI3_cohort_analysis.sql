-- create cohorts: all users who started yelping in 2019; divided by month
drop table if exists smmi_tmp_cohorts;
create table smmi_tmp_cohorts as 
select
	user_id
	,strftime('%m',yelping_since) as yelping_since_month
from user
where strftime('%Y',yelping_since) = '2019';
create index IDX_smmi_tmp_cohorts on smmi_tmp_cohorts(user_id);

-- group all reviews made in 2019 per user/ per month
drop table if exists smmi_tmp_reviews;
create table smmi_tmp_reviews as 
select
	user_id
	,count(distinct case when strftime('%m',date) = '01' then review_id else null end) as review_month_01
	,count(distinct case when strftime('%m',date) = '02' then review_id else null end) as review_month_02
	,count(distinct case when strftime('%m',date) = '03' then review_id else null end) as review_month_03
	,count(distinct case when strftime('%m',date) = '04' then review_id else null end) as review_month_04
	,count(distinct case when strftime('%m',date) = '05' then review_id else null end) as review_month_05
	,count(distinct case when strftime('%m',date) = '06' then review_id else null end) as review_month_06
	,count(distinct case when strftime('%m',date) = '07' then review_id else null end) as review_month_07
	,count(distinct case when strftime('%m',date) = '08' then review_id else null end) as review_month_08
	,count(distinct case when strftime('%m',date) = '09' then review_id else null end) as review_month_09
	,count(distinct case when strftime('%m',date) = '10' then review_id else null end) as review_month_10
	,count(distinct case when strftime('%m',date) = '11' then review_id else null end) as review_month_11
	,count(distinct case when strftime('%m',date) = '12' then review_id else null end) as review_month_12
from review
where strftime('%Y',date) = '2019'
group by 1;
create index IDX_smmi_tmp_reviews on smmi_tmp_reviews(user_id);

-- merge cohorts with nr of reviews
drop table if exists smmi_tmp_cohorts_reviews;
create table smmi_tmp_cohorts_reviews as 
select
	c.user_id
	,c.yelping_since_month
	,ifnull(r.review_month_01,0) as review_month_01
	,ifnull(r.review_month_02,0) as review_month_02
	,ifnull(r.review_month_03,0) as review_month_03
	,ifnull(r.review_month_04,0) as review_month_04
	,ifnull(r.review_month_05,0) as review_month_05
	,ifnull(r.review_month_06,0) as review_month_06
	,ifnull(r.review_month_07,0) as review_month_07
	,ifnull(r.review_month_08,0) as review_month_08
	,ifnull(r.review_month_09,0) as review_month_09
	,ifnull(r.review_month_10,0) as review_month_10
	,ifnull(r.review_month_11,0) as review_month_11
	,ifnull(r.review_month_12,0) as review_month_12
from smmi_tmp_cohorts c
left join smmi_tmp_reviews r
	on c.user_id = r.user_id;
	
-- final cohort analysis v1: counting number of unique reviews
select
	yelping_since_month
	,sum(review_month_01) as review_month_01
	,sum(review_month_02) as review_month_02
	,sum(review_month_03) as review_month_03
	,sum(review_month_04) as review_month_04
	,sum(review_month_05) as review_month_05
	,sum(review_month_06) as review_month_06
	,sum(review_month_07) as review_month_07
	,sum(review_month_08) as review_month_08
	,sum(review_month_09) as review_month_09
	,sum(review_month_10) as review_month_10
	,sum(review_month_11) as review_month_11
	,sum(review_month_12) as review_month_12
from smmi_tmp_cohorts_reviews
group by 1
order by 1;

-- final cohort analysis v2: counting number of unique users posting reviews
select
	yelping_since_month
	,count(distinct user_id) as distinct_user_month_01
	,count(distinct user_id) as distinct_user_month_01
	,count(distinct user_id) as distinct_user_month_01
	,count(distinct user_id) as distinct_user_month_01
	,count(distinct user_id) as distinct_user_month_01
	,count(distinct user_id) as distinct_user_month_01
	,count(distinct user_id) as distinct_user_month_01
	,count(distinct user_id) as distinct_user_month_01
	,count(distinct user_id) as distinct_user_month_01
	,count(distinct user_id) as distinct_user_month_01
	,count(distinct user_id) as distinct_user_month_01
	,count(distinct user_id) as distinct_user_month_01
from smmi_tmp_cohorts_reviews
group by 1
order by 1;

-- final cohort analysis v3: review_month as delta vs yelping_since_month (for visual comparison)
select
	yelping_since_month
	,sum(review_month_01) as review_month
	,sum(review_month_02) as review_month_plus1
	,sum(review_month_03) as review_month_plus2
	,sum(review_month_04) as review_month_plus3
	,sum(review_month_05) as review_month_plus4
	,sum(review_month_06) as review_month_plus5
	,sum(review_month_07) as review_month_plus6
	,sum(review_month_08) as review_month_plus7
	,sum(review_month_09) as review_month_plus8
	,sum(review_month_10) as review_month_plus9
	,sum(review_month_11) as review_month_plus10
	,sum(review_month_12) as review_month_plus11
from smmi_tmp_cohorts_reviews
where yelping_since_month = '01'
union
select
	yelping_since_month
	,sum(review_month_02) as review_month
	,sum(review_month_03) as review_month_plus1
	,sum(review_month_04) as review_month_plus2
	,sum(review_month_05) as review_month_plus3
	,sum(review_month_06) as review_month_plus4
	,sum(review_month_07) as review_month_plus5
	,sum(review_month_08) as review_month_plus6
	,sum(review_month_09) as review_month_plus7
	,sum(review_month_10) as review_month_plus8
	,sum(review_month_11) as review_month_plus9
	,sum(review_month_12) as review_month_plus10
	,null as review_month_plus11
from smmi_tmp_cohorts_reviews
where yelping_since_month = '02'
union
select
	yelping_since_month
	,sum(review_month_03) as review_month
	,sum(review_month_04) as review_month_plus1
	,sum(review_month_05) as review_month_plus2
	,sum(review_month_06) as review_month_plus3
	,sum(review_month_07) as review_month_plus4
	,sum(review_month_08) as review_month_plus5
	,sum(review_month_09) as review_month_plus6
	,sum(review_month_10) as review_month_plus7
	,sum(review_month_11) as review_month_plus8
	,sum(review_month_12) as review_month_plus9
	,null as review_month_plus10
	,null as review_month_plus11
from smmi_tmp_cohorts_reviews
where yelping_since_month = '03'
union
select
	yelping_since_month
	,sum(review_month_04) as review_month
	,sum(review_month_05) as review_month_plus1
	,sum(review_month_06) as review_month_plus2
	,sum(review_month_07) as review_month_plus3
	,sum(review_month_08) as review_month_plus4
	,sum(review_month_09) as review_month_plus5
	,sum(review_month_10) as review_month_plus6
	,sum(review_month_11) as review_month_plus7
	,sum(review_month_12) as review_month_plus8
	,null as review_month_plus9
	,null as review_month_plus10
	,null as review_month_plus11
from smmi_tmp_cohorts_reviews
where yelping_since_month = '04'
union
select
	yelping_since_month
	,sum(review_month_05) as review_month
	,sum(review_month_06) as review_month_plus1
	,sum(review_month_07) as review_month_plus2
	,sum(review_month_08) as review_month_plus3
	,sum(review_month_09) as review_month_plus4
	,sum(review_month_10) as review_month_plus5
	,sum(review_month_11) as review_month_plus6
	,sum(review_month_12) as review_month_plus7
	,null as review_month_plus8
	,null as review_month_plus9
	,null as review_month_plus10
	,null as review_month_plus11
from smmi_tmp_cohorts_reviews
where yelping_since_month = '05'
union
select
	yelping_since_month
	,sum(review_month_06) as review_month
	,sum(review_month_07) as review_month_plus1
	,sum(review_month_08) as review_month_plus2
	,sum(review_month_09) as review_month_plus3
	,sum(review_month_10) as review_month_plus4
	,sum(review_month_11) as review_month_plus5
	,sum(review_month_12) as review_month_plus6
	,null as review_month_plus7
	,null as review_month_plus8
	,null as review_month_plus9
	,null as review_month_plus10
	,null as review_month_plus11
from smmi_tmp_cohorts_reviews
where yelping_since_month = '06'
union
select
	yelping_since_month
	,sum(review_month_07) as review_month
	,sum(review_month_08) as review_month_plus1
	,sum(review_month_09) as review_month_plus2
	,sum(review_month_10) as review_month_plus3
	,sum(review_month_11) as review_month_plus4
	,sum(review_month_12) as review_month_plus5
	,null as review_month_plus6
	,null as review_month_plus7
	,null as review_month_plus8
	,null as review_month_plus9
	,null as review_month_plus10
	,null as review_month_plus11
from smmi_tmp_cohorts_reviews
where yelping_since_month = '07'
union
select
	yelping_since_month
	,sum(review_month_08) as review_month
	,sum(review_month_09) as review_month_plus1
	,sum(review_month_10) as review_month_plus2
	,sum(review_month_11) as review_month_plus3
	,sum(review_month_12) as review_month_plus4
	,null as review_month_plus5
	,null as review_month_plus6
	,null as review_month_plus7
	,null as review_month_plus8
	,null as review_month_plus9
	,null as review_month_plus10
	,null as review_month_plus11
from smmi_tmp_cohorts_reviews
where yelping_since_month = '08'
union
select
	yelping_since_month
	,sum(review_month_09) as review_month
	,sum(review_month_10) as review_month_plus1
	,sum(review_month_11) as review_month_plus2
	,sum(review_month_12) as review_month_plus3
	,null as review_month_plus4
	,null as review_month_plus5
	,null as review_month_plus6
	,null as review_month_plus7
	,null as review_month_plus8
	,null as review_month_plus9
	,null as review_month_plus10
	,null as review_month_plus11
from smmi_tmp_cohorts_reviews
where yelping_since_month = '09'
union
select
	yelping_since_month
	,sum(review_month_10) as review_month
	,sum(review_month_11) as review_month_plus1
	,sum(review_month_12) as review_month_plus2
	,null as review_month_plus3
	,null as review_month_plus4
	,null as review_month_plus5
	,null as review_month_plus6
	,null as review_month_plus7
	,null as review_month_plus8
	,null as review_month_plus9
	,null as review_month_plus10
	,null as review_month_plus11
from smmi_tmp_cohorts_reviews
where yelping_since_month = '10'
union
select
	yelping_since_month
	,sum(review_month_11) as review_month
	,sum(review_month_12) as review_month_plus1
	,null as review_month_plus2
	,null as review_month_plus3
	,null as review_month_plus4
	,null as review_month_plus5
	,null as review_month_plus6
	,null as review_month_plus7
	,null as review_month_plus8
	,null as review_month_plus9
	,null as review_month_plus10
	,null as review_month_plus11
from smmi_tmp_cohorts_reviews
where yelping_since_month = '11'
union
select
	yelping_since_month
	,sum(review_month_12) as review_month
	,null as review_month_plus1
	,null as review_month_plus2
	,null as review_month_plus3
	,null as review_month_plus4
	,null as review_month_plus5
	,null as review_month_plus6
	,null as review_month_plus7
	,null as review_month_plus8
	,null as review_month_plus9
	,null as review_month_plus10
	,null as review_month_plus11
from smmi_tmp_cohorts_reviews
where yelping_since_month = '12'
;

-- drop all temp tables
drop table if exists smmi_tmp_cohorts;
drop table if exists smmi_tmp_reviews;
drop table if exists smmi_tmp_cohorts_reviews;