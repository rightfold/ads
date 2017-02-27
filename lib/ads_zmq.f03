MODULE ads_zmq

    INTERFACE

        FUNCTION zmq_ctx_new() BIND(C)
            USE iso_c_binding
            IMPLICIT NONE
            TYPE(c_ptr) :: zmq_ctx_new
        END FUNCTION

        FUNCTION zmq_ctx_term(context) BIND(C)
            USE iso_c_binding
            IMPLICIT NONE
            TYPE(c_ptr), INTENT(IN), VALUE :: context
            INTEGER(c_int) :: zmq_ctx_term
        END FUNCTION

        FUNCTION zmq_socket(context, type) BIND(C)
            USE iso_c_binding
            IMPLICIT NONE
            TYPE(c_ptr), INTENT(IN), VALUE :: context
            INTEGER(c_int), INTENT(IN), VALUE :: type
            TYPE(c_ptr) :: zmq_socket
        END FUNCTION

        FUNCTION zmq_close(socket) BIND(C)
            USE iso_c_binding
            IMPLICIT NONE
            TYPE(c_ptr), INTENT(IN), VALUE :: socket
            INTEGER(c_int) :: zmq_close
        END FUNCTION

        FUNCTION zmq_bind(socket, endpoint) BIND(C)
            USE iso_c_binding
            IMPLICIT NONE
            TYPE(c_ptr), INTENT(IN), VALUE :: socket
            CHARACTER(c_char), INTENT(IN) :: endpoint(*)
            INTEGER(c_int) :: zmq_bind
        END FUNCTION

    END INTERFACE

END MODULE
