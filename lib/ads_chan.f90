MODULE ads_chan

    USE ads_corr, ONLY: xcorr_norm

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

    SUBROUTINE advance(previous, current, interval, now, anomaly)
        REAL, INTENT(INOUT), DIMENSION(:) :: previous, current
        REAL, INTENT(IN) :: interval
        REAL, INTENT(INOUT) :: now
        LOGICAL, INTENT(OUT) :: anomaly
        INTEGER :: buffer_idx
        buffer_idx = buffer_index(interval, now)
        IF (buffer_idx .EQ. 1) THEN
            anomaly = .FALSE.
        ELSE
            anomaly = xcorr_norm(previous, current) .LT. 0.75
            IF (buffer_idx .EQ. 2) THEN
                previous = current
            ELSE
                previous = 0
            END IF
            current = 0
        END IF
        now = now - interval * (buffer_idx - 1)
    END SUBROUTINE

END MODULE
