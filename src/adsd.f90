PROGRAM adsd

    USE ads_zmq
    USE iso_c_binding, ONLY: c_associated, c_int, c_null_char, c_null_ptr, c_ptr

    IMPLICIT NONE

    TYPE(c_ptr) :: context, socket
    INTEGER :: status
    INTEGER(c_int) :: zmq_status

    context = c_null_ptr
    socket = c_null_ptr
    status = 1

    context = zmq_ctx_new()
    IF (.NOT. c_associated(context)) THEN
        CALL perror('adsd')
        GO TO 500
    END IF

    socket = zmq_socket(context, 7)
    IF (.NOT. c_associated(socket)) THEN
        CALL perror('adsd')
        GO TO 499
    END IF

    zmq_status = zmq_bind(socket, "tcp://0.0.0.0:1337" // c_null_char)
    IF (zmq_status .EQ. -1) THEN
        CALL perror('adsd')
        GO TO 498
    END IF

    status = 0

498 IF (c_associated(socket)) THEN
        zmq_status = zmq_close(socket)
        IF (zmq_status .EQ. -1) CALL perror('adsd')
    END IF

499 IF (c_associated(context)) THEN
        zmq_status = zmq_ctx_term(context)
        IF (zmq_status .EQ. -1) CALL perror('adsd')
    END IF

500 CALL exit(status)

END PROGRAM
