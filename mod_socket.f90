module mod_socket
    use, intrinsic :: iso_c_binding
    implicit none
    
    public

    ! Address Families
    integer(c_int), parameter :: AF_INET  =  2
    integer(c_int), parameter :: AF_INET6 = 10
    
    ! Type of Sockets
    integer(c_int), parameter :: SOCK_STREAM = 1
    integer(c_int), parameter :: SOCK_DGRAM  = 2

    interface
        ! int socket(int domain, int type, int protocol);
        function c_socket(domain, type, protocol) bind(c, name="socket")
            use, intrinsic :: iso_c_binding
            integer(kind=c_int) :: c_socket
            integer(kind=c_int), value :: domain, type, protocol
        end function
    
        ! int bind(int sockfd, const struct sockaddr *addr, socklen_t addrlen);
        function c_bind(sockfd, addr, addrlen) bind(c, name="bind")
            use, intrinsic :: iso_c_binding
            integer(kind=c_int) :: c_bind
            integer(kind=c_int), value :: sockfd
            type(c_ptr), value :: addr
            integer(kind=c_int64_t), value :: addrlen
        end function
    
        ! int listen(int sockfd, int backlog);
        function c_listen(sockfd, backlog) bind(c, name="listen")
            use, intrinsic :: iso_c_binding
            integer(kind=c_int) :: c_listen
            integer(kind=c_int), value :: sockfd, backlog
        end function
    
        ! int connect(int sockfd, const struct sockaddr *addr, socklen_t addrlen);
        function c_connect(sockfd, addr, addrlen) bind(c, name="connect")
            use, intrinsic :: iso_c_binding
            integer(c_int) :: c_connect
            integer(c_int), value :: sockfd
            type(c_ptr), value :: addr
            integer(kind=c_int64_t), value :: addrlen
        end function

        ! ssize_t send(int sockfd, const void *buf, size_t len, int flags);
        function c_send(sockfd, buf, len, flags) bind (c, name="send")
            use, intrinsic :: iso_c_binding
            integer(kind=c_int) :: c_send
            integer(kind=c_int), value :: sockfd, len, flags
            character(1,kind=c_char), value :: buf
        end function

        ! ssize_t recv(int sockfd, const void *buf, size_t len, int flags);
        function c_recv(sockfd, buf, len, flags) bind (c, name="recv")
            use, intrinsic :: iso_c_binding
            integer(kind=c_int) :: c_recv
            integer(kind=c_int), value :: sockfd, len, flags
            type(c_ptr), value :: buf
        end function

        ! int accept(int sockfd, struct sockaddr *addr, socklen_t *addrlen);
        function c_accept(sockfd, addr, addrlen) bind (c, name="accept")
            use, intrinsic :: iso_c_binding
            integer(kind=c_int) :: c_accept
            integer(kind=c_int), value :: sockfd
            type(c_ptr), value :: addr, addrlen
        end function

        ! uint32_t htonl(uint32_t hostlong);
        function c_htonl(hostlong) bind (c, name="htonl")
            use, intrinsic :: iso_c_binding
            integer(kind=c_int) :: c_htonl
            integer(kind=c_int), value :: hostlong
        end function

        ! uint16_t htons(uint16_t hostshort);
        function c_htons(hostshort) bind (c, name="htons")
            use, intrinsic :: iso_c_binding
            integer(kind=c_short) :: c_htons
            integer(kind=c_int), value :: hostshort
        end function

        ! void *memset(void *s, int c, size_t n);
        subroutine c_memset(s, c, n) bind(c,name="memset")
            use, intrinsic :: iso_c_binding
            !type(c_ptr) :: c_memset
            type(c_ptr), value, intent(in) :: s
            integer(c_int), value, intent(in) :: c
            integer(c_size_t), value, intent(in) :: n
        end subroutine

        ! size_t strlen(const char *str);
        function c_strlen(str) bind(c,name="strlen")
            use, intrinsic :: iso_c_binding
            integer(c_size_t) :: c_strlen
            type(c_ptr), value, intent(in) :: str
        end function

        ! int strcmp(const char *s1, const char *s2);
        function c_strcmp(s1, s2) bind(c,name="strcmp")
            use, intrinsic :: iso_c_binding
            integer(c_int) :: c_strcmp
            type(c_ptr), value, intent(in) :: s1, s2
        end function
  end interface

end module mod_socket