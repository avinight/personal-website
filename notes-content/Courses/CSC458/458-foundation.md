
Tags: #book

---

Layers of the Internet
- Application
- Transport
	- Provides reliable, in-sequence delivery of data from end-to-end on behalf of application.
- Network
	-  Provides “best-effort”, but unreliable, delivery of datagrams.
- Link
	- Carries data over (usually) point-to-point links between hosts and routers; or between routers and routers.

FTP
- File Transfer Protocol

API
- Application Programming Interface
- Application requests TCP connection with “B”

TCP
- Transmission Control Protocol
- Creates TCP “Connection setup” packet
- TCP requests IP packet to be sent to “B”

IP
- Internet Protocol
- Creates IP packet with correct addresses.
- IP requests packet to be sent to router.

We encapsulate the TCP packet in the IP packet

Link protocol
- Creates MAC frame with Frame Check Sequence (FCS).
- Wait for Access to the line.
- MAC requests PHY to send each bit of the frame

OSI model 
- Open Systems Interconnection Model
- A 7-layer model

URL - Uniform Resource Locator

## Packet/Circuit Switching
---
Statistical Multiplexing

SMG = 2C/R where 




<h6 style="font-weight: normal;">See Also</h6>

---

<h6 style="font-weight: normal;">References</h6>

---