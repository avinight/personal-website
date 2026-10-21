Tags:

---

### Intro to Sockets
---
Stream sockets

##### Socket Prototype
```C
int socket(int domain, int type, int protocol);
```
- domain sets protocol; set of rules used for communication ( PF_INET, AF_INET )
	- AF_INET: Address family
	- PF_INET: Protocol familt
- type, we will use SOCK_STREAM
- protocol, 0

we will call socket like
```C
int socket(AF_INET, SOCK_STREAM, 0);
```

![[Socket Port Selection.png]]

![[Sockets.SOCK DGRAM.png]]
### Socket Configuration
---
memset

##### Bind Prototype
```C
int bind(int socket, const struct sockaddr *address, socklen_t address_len);
```
`socket` sets up our stream socket, but doesn't set the address. We will use `bind` for this.

##### struct sockaddr_in
```C
struct sockaddr_in {
	short sin_family;
	u_short sin_port;
	struct in_addr sin_addr;
	char sin_zero[8];
};
```
- Type of socket address for the internet

Well-reserved ports: 0 - 1023
Registered ports: 1024 - 49151
Dynamic ports: 49152 - 65535
Telnet: runs on port 23

`htons(int port)` stands for host-to-network-short. Converts byte order of host machine to network byte order.
We have to make sure that the two machines that are communicating are speaking the same languages. We call these agreements, protocols.

we need to set `s_addr` of the inside `struct in_addr` to `INADDR_ANY`, configuring socket to accept connections from any of the addresses of the machine. A machine can have multiple network interface cards and plugged into separate network. And and address for itself.

`localhost` or `127.0.0.1`

`sin_zero` makes the sockaddr_in struct the same length as sockaddr struct. When malloc the space for this struct, those bytes are not reset in any way. They hold values that were there in memory before the malloc call. 
For Security:
```C
memset(&(addr.sin_zero), 0, 8);
```

bind is a syscall and should be error checked. Suppose port you picked is not available because already in use. `bind` would fail, so you wouldn't want the program to continue running without alerting you.
```C
int bind(listen_soc, (struct sockaddr *) &addr, sizeof(struct sockaddr_in));
```
 - we need to cast to keep compiler happy.

Tell machine to start looking for connections: use `listen`.
```C
int listen(int socket, int backlog);
```
Listen sets up data structure needed to store these partial connections. Backlog is the max number of partially completed connections it can hold. 

There might be another client attempting to connect when there is already a connection established. Listen keeps a number of pending connections; a list of connections that haven't heard back from the server.

![[Sockets Bind Multiple Connections.png]]

![[Sockets Follow Up Question.png]]

![[Sockets Follow Up Question (2).png]]
### Setting up a connection
---
accept


"when" accept returns the second parameter will point to a struct that holds the clients address information. 
accept() is a blocking system call, it waits until a connection is established. Calling accept and no client is attempting to connect, it will block. It can return if there is an error. So check if it is -1. On success, its an integer that represents a new socket to communicate with the client.

Since return value is used to return a new socket, it can't be used to give us address of the client. That's what the second param is used for. Allocate memory for struct then `accept()` uses the pointer to set the fields of the address param.

Function type uses a generic, but actual call uses a specific struct for a particular address family.

`struct sockaddr_in client_addr` holds address of machine on the other end

```C
unsigned int client_len = sizeof(struct sockaddr_in);
```
Then pass address of this value to the third parameter of accept

```C
int client_socket = accept(listen_soc, (struct sockaddr *)&client_addr, &client_len);
```

```C
int connect(soc, const struct sockaddr *address, socklen_t addrlen);
```
- success if connected to server
- failure if failed to connect to server


```C
int getaddrinfo(char *host, char *service, struct addrinfo *hints, struct addrinfo **result);
```
- set second and third params to `NULL`. 
- fourth param is an address of a pointer to a linked list of structs.
	- There might be more than one address that satisfies request for address info
	- Each element in list is information about one of those addresses.
Expects you to create pointer then pass the 

![[Sockets Follow Up.png]]
![[IP Address Lookup.png]]
### Socket communication
---
##### server.c
```C
listen_soc = socket(...)
bind(listen_soc, ...)
listen(listen_soc, ...)

int client_socket = accept(listen_soc, ...)

if (client_socket == -1) {
	perror("accept");
	exit(1);
}

write(client_socket, "hello\r\n", 7);

char line[10];
read(client_socket, line, 10);

line[9] = '\0';
printf("I read %s\n", line);

close(listen_soc);

```
##### client.c
```C
soc = socket(...)
if (connect(soc, ...) == -1) {
	perror("connect");
	exit(1);
}

char buf[10];
read(soc, buf, 7);
buf[7] = '\0';
printf("I read %s\n", buf);

write(soc, "0123456789", 10);

close(soc);
```

- closing socket solves when program doesn't immediately terminate, which leaves the partner in the conversation hanging.
sockets are an index in the file descriptor table (socket descriptor).
We can use the same calls we use for file descriptors.
![[Socket Communication Flowchart.png]]

![[Socket Calls And File Descriptors.png]]

![[Sockets Follow Up (2).png]]
<h6 style="font-weight: normal;">See Also</h6>

---

<h6 style="font-weight: normal;">References</h6>

---
- [https://youtu.be/zDjEhfqt8wA](https://youtu.be/zDjEhfqt8wA "Share link")
- [https://youtu.be/C4OzWoxC56Y](https://youtu.be/C4OzWoxC56Y)
- [https://youtu.be/gpFNwCA6hxY](https://youtu.be/gpFNwCA6hxY "Share link")
- [https://youtu.be/ID2dSWHdb8s](https://youtu.be/ID2dSWHdb8s "Share link")