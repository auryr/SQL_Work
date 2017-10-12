use Vidsi; 
SELECT subscriber_id, COUNT(video_id) video_views ,
ROW_NUMBER()OVER(PARTITION BY subscriber_id ORDER BY subscriber_id,video_id)
FROM tvsSubscribersStreaming
GROUP BY subscriber_id,video_id,CONCAT(DATEPART(month, streaming_date) ,'/', DATEPART(year, streaming_date))



use master;