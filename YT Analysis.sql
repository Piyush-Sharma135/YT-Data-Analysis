-- Data Overview to get idea about level of detail
select TOP 10 * from namastesql.dbo.video_data;

--1 Highest Views/Video
select 
	video_data.[Video Category], 
	SUM(video_data.Views) as total_views,
	COUNT(video_data.[Video Category]) as total_videos,
	ROUND(SUM(video_data.Views)/COUNT(video_data.[Video Category]),2) as avg_views_per_video
from namastesql.dbo.video_data
group by [Video Category]
order by 4 desc;


--2 Total Revenue in year
select 
	Round(SUM(video_data.[RPM (Rs)]/1000*video_data.Views),2) as Total_Revenue
from namastesql.dbo.video_data;


--3 Exploring Corelation
select 
	video_data.[Video Category],
	Round(avg(video_data.Views)/1000,2) as avg_view_count_in_thousands, 
	ROUND(avg(video_data.CTR),4)*100 as avg_ctr, 
	Round(avg(video_data.[AVD (Mins)]),3) as avg_avd,
	Round(SUM(video_data.[RPM (Rs)]/1000*video_data.Views)/100000,2) as Category_Wise_Revenue_in_lakhs
from namastesql.dbo.video_data
group by [Video Category]
order by 2 desc;

-- It is clear from analysis that there exists a linear corelation. 
-- Categories with more avg_views have more avg_ctr and avg_avd. 
-- Consequently both of these parameters are leading to greater revenue stream 


--4 Category wise Revenue
select 
	video_data.[Video Category], 
	Round(SUM(video_data.[RPM (Rs)]/1000*video_data.Views),2) as Category_Wise_Revenue
from namastesql.dbo.video_data
group by [Video Category]
order by 2 desc;


--5 Exploring sub_gain metric vis a vis category
select 
	video_data.[Video Category] as category, 
	sum([Subscribers Gained]) as total_sub_gain,
	round(avg([Subscribers Gained]),2) as avg_sub_gain
from namastesql.dbo.video_data
group by [Video Category]
order by 2 desc;

-- It is evident from data that to increase sub_gain KPI we need to focus more on Spoken English Category

