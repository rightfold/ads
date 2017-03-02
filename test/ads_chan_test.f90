PROGRAM ads_chan_test

    USE ads_chan

    IMPLICIT NONE

    INTEGER :: status

    REAL, DIMENSION(5) :: previous, current
    REAL :: interval, now
    LOGICAL :: anomaly

    status = 0

    previous = 0
    current = 0
    interval = 8

    !----------------------------------------------------------------------!

    now = 7
    IF (buffer_index(interval, now) .NE. 1) THEN
        status = status + 1
        PRINT *, 'buffer should not be full', interval, now
    END IF

    now = 8
    IF (buffer_index(interval, now) .NE. 2) THEN
        status = status + 1
        PRINT *, 'buffer should be full', interval, now
    END IF

    !----------------------------------------------------------------------!

    CALL feed(current(1:4), interval, -1.0, 1.0)
    CALL feed(current(1:4), interval, 0.0, 2.0)
    CALL feed(current(1:4), interval, 2.0, 3.0)
    CALL feed(current(1:4), interval, 3.0, 4.0)
    CALL feed(current(1:4), interval, 7.0, 5.0)
    CALL feed(current(1:4), interval, 8.0, 6.0)

    IF (any(current .NE. (/ 2, 4, 0, 5, 0 /))) THEN
        status = status + 1
        PRINT *, 'current should not be ', current
    END IF

    !----------------------------------------------------------------------!

    previous = (/ 1, 2, 3, 4, 5 /)
    current = (/ 2, 3, 4, 5, 6 /)
    now = 0
    CALL advance(previous, current, interval, now, anomaly)
    IF (any(previous .NE. (/ 1, 2, 3, 4, 5 /))) THEN
        status = status + 1
        PRINT *, 'previous should not be ', previous
    END IF
    IF (any(current .NE. (/ 2, 3, 4, 5, 6 /))) THEN
        status = status + 1
        PRINT *, 'current should not be ', current
    END IF
    IF (now .NE. 0) THEN
        status = status + 1
        PRINT *, 'now should not be ', now
    END IF
    IF (anomaly) THEN
        status = status + 1
        PRINT *, 'anomaly should not be ', anomaly
    END IF

    previous = (/ 1, 2, 3, 4, 5 /)
    current = (/ 200, -300, 400, -500, 600 /)
    now = interval
    CALL advance(previous, current, interval, now, anomaly)
    IF (any(previous .NE. (/ 200, -300, 400, -500, 600 /))) THEN
        status = status + 1
        PRINT *, 'previous should not be ', previous
    END IF
    IF (any(current .NE. 0)) THEN
        status = status + 1
        PRINT *, 'current should not be ', current
    END IF
    IF (now .NE. 0) THEN
        status = status + 1
        PRINT *, 'now should not be ', now
    END IF
    IF (.NOT. anomaly) THEN
        status = status + 1
        PRINT *, 'anomaly should be ', anomaly
    END IF

    previous = (/ 1, 2, 3, 4, 5 /)
    current = (/ 200, -300, 400, -500, 600 /)
    now = interval * 2
    CALL advance(previous, current, interval, now, anomaly)
    IF (any(previous .NE. 0)) THEN
        status = status + 1
        PRINT *, 'previous should not be ', previous
    END IF
    IF (any(current .NE. 0)) THEN
        status = status + 1
        PRINT *, 'current should not be ', current
    END IF
    IF (now .NE. 0) THEN
        status = status + 1
        PRINT *, 'now should not be ', now
    END IF
    IF (.NOT. anomaly) THEN
        status = status + 1
        PRINT *, 'anomaly should be ', anomaly
    END IF

    !----------------------------------------------------------------------!

    CALL exit(status)

END PROGRAM
