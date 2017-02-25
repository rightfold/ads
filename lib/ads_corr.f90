MODULE ads_corr

    IMPLICIT NONE

CONTAINS

    PURE FUNCTION xcorr(u, v)
        REAL, INTENT(IN), DIMENSION(:) :: u, v
        REAL :: xcorr
        xcorr = dot_product(u, v)
    END FUNCTION

    PURE FUNCTION xcorr_norm(u, v)
        REAL, INTENT(IN), DIMENSION(:) :: u, v
        REAL :: xcorr_norm
        xcorr_norm = xcorr(u, v) / sqrt(sum(u ** 2) * sum(v ** 2))
    END FUNCTION

END MODULE
