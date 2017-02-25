PROGRAM ads_corr_test

    USE ads_corr

    IMPLICIT NONE

    INTEGER :: status

    REAL, DIMENSION(4) :: u, v, w
    REAL :: uv, vw

    status = 0

    u = (/ 1, 2, -1, 3 /)
    v = (/ 1, 3, -2, 3 /)
    w = (/ 6, 5, 6, 8 /)

    uv = xcorr_norm(u, v)
    vw = xcorr_norm(v, w)

    IF (uv .LT. 0.95) THEN
        status = status + 1
        PRINT *, 'xcorr_norm(u, v) should not be ', uv
    END IF

    IF (vw .GT. 0.55) THEN
        status = status + 1
        PRINT *, 'xcorr_norm(v, w) should not be ', vw
    END IF

    CALL exit(status)

END PROGRAM
