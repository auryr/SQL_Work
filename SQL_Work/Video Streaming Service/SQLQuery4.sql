

DECLARE @cnt INT = 1;

WHILE @cnt <= 5000
BEGIN
   
	update tvsSubscribersStreaming 
	set streaming_date=DATEADD (d , (FLOOR(RAND()*(1-93)+93)) , '2017-01-01') ,
	video_id=FLOOR(RAND()*(1-21)+21), subscriber_id=FLOOR(RAND()*(1-15)+15)
	where id=@cnt;

   SET @cnt = @cnt + 1;
END;

PRINT 'Done simulated FOR LOOP on TechOnTheNet.com';
GO