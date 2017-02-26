PROGRAM ads_sys_test

    USE ads_sys

    IMPLICIT NONE

    INTEGER :: status

    REAL, DIMENSION(5) :: buffer
    REAL :: interval, now, value

    status = 0

    buffer = 0
    interval = 8

    !----------------------------------------------------------------------!

    now = 7
    IF (full(buffer, interval, now)) THEN
        status = status + 1
        PRINT *, 'buffer should not be full', interval, now
    END IF

    now = 8
    IF (.NOT. full(buffer, interval, now)) THEN
        status = status + 1
        PRINT *, 'buffer should be full', interval, now
    END IF

    !----------------------------------------------------------------------!

    CALL feed(buffer(1:4), interval, -1.0, 1.0)
    CALL feed(buffer(1:4), interval, 0.0, 2.0)
    CALL feed(buffer(1:4), interval, 2.0, 3.0)
    CALL feed(buffer(1:4), interval, 3.0, 4.0)
    CALL feed(buffer(1:4), interval, 7.0, 5.0)
    CALL feed(buffer(1:4), interval, 8.0, 6.0)

    IF (any(buffer .NE. (/ 2, 4, 0, 5, 0 /))) THEN
        status = status + 1
        PRINT *, 'buffer should not be ', buffer
    END IF

    !----------------------------------------------------------------------!

    CALL exit(status)

END PROGRAM
