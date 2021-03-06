use Vidsi;
 
DECLARE @stream_date_i date = '2017-01-01';
DECLARE @stream_date_f date = '2017-01-31';
DECLARE @rank_limit int=20;

SELECT  ss.video_rank, vi.title, ss.video_streams,ss.strDate, su.id,  su.firstname , su.lastname 
FROM
(
	SELECT subscriber_id, video_id, COUNT(video_id) video_streams ,
	CONCAT(DATEPART(month, streaming_date) ,'/', DATEPART(year, streaming_date))as strDate,
	ROW_NUMBER()OVER(PARTITION BY subscriber_id ORDER BY subscriber_id,COUNT(video_id) desc) as video_rank
	FROM tvsSubscribersStreaming
	WHERE streaming_date between  @stream_date_i and @stream_date_f
	GROUP BY subscriber_id,video_id,CONCAT(DATEPART(month, streaming_date) ,'/', DATEPART(year, streaming_date))
) AS ss 
INNER JOIN tvssubscribers su 
	ON ss.subscriber_id = su.id
INNER JOIN tvsvideos vi
	ON ss.video_id = vi.id
WHERE video_rank<=@rank_limit
ORDER BY ss.subscriber_id,video_rank 



use master;