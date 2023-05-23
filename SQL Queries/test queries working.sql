--single flight
SELECT * FROM Flights WHERE 
(DepartureCode = 'LHR' AND StopOverCode = 'SFO' AND DepartureTime >= '2014-09-24 00:00:00.000' AND DepartureTime <= '2014-10-25 00:00:00.000') OR 
(StopOverCode = 'LHR' AND DestinationCode = 'SFO' AND DepartureTimeStopOver >= '2014-09-24 00:00:00.000' AND DepartureTimeStopOver <= '2014-10-25 00:00:00.000') OR 
(DepartureCode = 'LHR' AND DestinationCode = 'SFO' AND DepartureTime >= '2014-09-24 00:00:00.000' AND DepartureTime <= '2014-10-25 00:00:00.000')


--All flights that have stopover or departure the same as a stopover or departure flight from sydney in the time period and have stopover or destination as LAX
    --All flights out of sydney in time period into temp table
    

SELECT * INTO #tempTable FROM Flights WHERE 
        (DepartureCode = 'LHR' and DepartureTime >= '2014-09-24 00:00:00.000' AND DepartureTime <= '2014-09-25 00:00:00.000') OR 
        (StopOverCode = 'LHR'AND DepartureTimeStopOver >= '2014-09-24 00:00:00.000' AND DepartureTimeStopOver <= '2014-09-25 00:00:00.000')

SELECT [f].[AirlineCode],

[t].[FlightNumber] as tflight,
[t].[DepartureCode] as tdepart,
[t].[StopOverCode] as tstop ,
 [t].[DestinationCode] as tdest ,
[t].[DepartureTime] as tdepartTime,
[t].[ArrivalTimeStopOver] as tstopArrival,
[t].[DepartureTimeStopOver] as tstopdeparture,
[t].[ArrivalTime] as tarrival,
[t].[PlaneCode],
[t].[Duration],
 [t].[DurationSecondLeg],
 [f].[FlightNumber] as fflight,
[f].[DepartureCode] as fdepart,
[f].[StopOverCode] as fstopover,
 [f].[DestinationCode] as fdestination,
[f].[DepartureTime] as fdeparttime,
[f].[ArrivalTimeStopOver] as fstoparrival,
[f].[DepartureTimeStopOver] as fstopdepart,
[f].[ArrivalTime] as farrrival,
[f].[PlaneCode],
[f].[Duration],
[f].[DurationSecondLeg]
 FROM Flights f
    INNER JOIN #tempTable t ON (f.DepartureCode = t.DestinationCode OR f.DepartureCode = t.StopOverCode 
    OR f.StopOverCode = t.DestinationCode OR f.StopOverCode = t.StopOverCode) AND f.StopOverCode != 'LHR' AND f.DepartureCode != 'LHR'
    WHERE (((f.StopOverCode = t.StopOverCode AND f.DepartureTimeStopOver > t.ArrivalTimeStopOver AND f.DepartureTimeStopOver < DATEADD(day,1,t.ArrivalTimeStopOver)) OR 
    (f.StopOverCode = t.DestinationCode AND f.DepartureTimeStopOver > t.ArrivalTime AND f.DepartureTimeStopOver < DATEADD(day,1,t.ArrivalTime))) AND f.DestinationCode = 'SFO') OR
       (((f.DepartureCode = t.StopOverCode AND f.DepartureTime > t.ArrivalTimeStopOver AND f.DepartureTime < DATEADD(day,1,t.ArrivalTimeStopOver)) OR 
       (f.DepartureCode = t.DestinationCode AND f.DepartureTime > t.ArrivalTime AND f.DepartureTime < DATEADD(day,1,t.ArrivalTime)))) AND (f.StopOverCode = 'SFO' OR f.DestinationCode = 'SFO')

        DROP TABLE #tempTable
