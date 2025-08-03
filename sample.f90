program socket_sample
    use, intrinsic :: iso_c_binding
    use mod_socket
    implicit none

    integer(c_int) :: lsock, asock, status
    type(sockaddr_in), target :: addr, client
    character(len=2), parameter :: crlf = c_carriage_return // c_new_line
    character(len=1024), target :: response = &
    "HTTP/1.1 200 OK" // crlf // &
    "Server: Fortran HTTP Server (Linux)" // crlf // &
    "Content-Type: text/html" // crlf // &
    "Content-Length: 23" // crlf // &
    "" // crlf // &
    "<h1>Hello, Fortran</h1>" // crlf // c_null_char

    integer(c_size_t) :: response_len
    lsock = c_socket(AF_INET, SOCK_STREAM, 0)

    if (lsock .lt. 0) then
        print*,"Error: Cannot make socket."
        stop 1
    end if

    call c_memset(c_loc(addr), 0, sizeof(addr))
    addr%sin_family = AF_INET
    addr%sin_port = c_htons(8080)
    addr%sin_addr = c_htonl(INADDR_ANY)
    
    status = c_bind(lsock, c_loc(addr), sizeof(addr))
    
    if (status .lt. 0) then
        print*, "Error: Cannot bind socket"
        stop 1
    end if

    status = c_listen(lsock, 5)
    
    do
        asock = c_accept(lsock, c_null_ptr, c_null_ptr)
        response_len = c_strlen(c_loc(response))
        print*, "Send Hello"
        status = c_send(asock, c_loc(response), response_len, 0)
        status = c_close(asock)
    enddo

    status = c_close(lsock)
end program socket_sample