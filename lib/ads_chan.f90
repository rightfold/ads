MODULE ads_chan

    IMPLICIT NONE

CONTAINS

    PURE FUNCTION buffer_index(interval, now)
        REAL, INTENT(IN) :: interval, now
        INTEGER :: buffer_index
        buffer_index = 1 + int(now / interval)
    END FUNCTION

    SUBROUTINE feed(buffer, interval, now, value)
        REAL, INTENT(INOUT), DIMENSION(:) :: buffer
        REAL, INTENT(IN) :: interval, now, value
        INTEGER :: bin
        IF (0 .LE. now .AND. now .LT. interval) THEN
            bin = 1 + int(size(buffer) / interval * now)
            buffer(bin) = value
        END IF
    END SUBROUTINE

END MODULE
