PROGRAM adsd

    USE ads_sys

    IMPLICIT NONE

    REAL, DIMENSION(25) :: input
    REAL, DIMENSION(5) :: buffer
    REAL :: interval, now, value
    INTEGER :: i, j

    interval = size(buffer)

    DO i = 1, size(input)
        input(i) = i
    END DO

    DO i = 1, size(input), int(interval)
        buffer = 0
        DO j = 1, int(interval)
            now = j - 1
            value = input(i + j - 1)
            CALL feed(buffer, interval, now, value)
            PRINT *, i + j - 1, j, full(size(buffer), interval, now + 1), buffer
        END DO
        PRINT *
    END DO

END PROGRAM
