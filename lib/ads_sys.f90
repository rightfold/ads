MODULE ads_sys

    IMPLICIT NONE

CONTAINS

    SUBROUTINE feed(buffer, interval, now, value)
        REAL, INTENT(INOUT), DIMENSION(:) :: buffer
        REAL, INTENT(IN) :: interval, now, value
        INTEGER :: bin
        IF (0 .LE. now .AND. now .LT. interval) THEN
            bin = 1 + size(buffer) / interval * now
            buffer(bin) = value
        END IF
    END SUBROUTINE

END MODULE
