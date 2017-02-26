MODULE ads_sys

    IMPLICIT NONE

    PRIVATE :: bin

CONTAINS

    PURE FUNCTION bin(size, interval, now)
        INTEGER, INTENT(IN) :: size
        REAL, INTENT(IN) :: interval, now
        INTEGER :: bin
        bin = 1 + size / interval * now
    END FUNCTION

    PURE FUNCTION full(buffer, interval, now)
        REAL, INTENT(IN), DIMENSION(:) :: buffer
        REAL, INTENT(IN) :: interval, now
        LOGICAL :: full
        full = bin(size(buffer), interval, now) .GT. size(buffer)
    END FUNCTION

    SUBROUTINE feed(buffer, interval, now, value)
        REAL, INTENT(INOUT), DIMENSION(:) :: buffer
        REAL, INTENT(IN) :: interval, now, value
        IF (0 .LE. now .AND. now .LT. interval) THEN
            buffer(bin(size(buffer), interval, now)) = value
        END IF
    END SUBROUTINE

END MODULE
