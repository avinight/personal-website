Tags: #lecture

---

## Lecture

repeaters amplify noise

cannot support multiple lan technologies - two rooms speaking different languages, a repeater cannot connect the two rooms

cut through switching -> reason for dest. address.

leaf and spine switches; top of rack switch
ttl - time to live : we need this bc the internet might have loops
##### Ethernet

Ethernet
- First widely used LAN technology
- uses CSMA/CD (Carrier Sense Multiple Access/Collision Detection)

Carrier Sense
- wait for link to become idle
- Channel idle: start transmitting
- Channel busy: wait until idle

Collision detection:
- No collision: transmission is complete
- Collision: abort mission and send jam signal

Random access
- After collision, wait a random time before trying again
- After the mth collision, choose K randomly from {0, …, 2m-1} and wait for K\*512 bit times before trying again
##### Limitations on Ethernet Length

Latency depends on physical length of link
- Time to propagate a packet from one end to the other

Suppose A sends a packet at time t
- And B sees an idle line at a time just before t+d so B happily starts transmitting a packet

B detects a collision, and sends jamming signal but A doesn’t see collision till t+2d.

A needs to wait for time 2d to detect collision
- So, A should keep transmitting during this period and keep an eye out for a possible collision.

Imposes restrictions on Ethernet
- Maximum length of the wire: 2500 meters
- Minimum length of the packet: 512 bits (64 bytes) <- Why?

##### Ethernet Frame Structure

Addresses: source and destination MAC addresses
- Use ifconfig to get your machine’s MAC address:
- Adaptor passes frame to network-level protocol
	- If destination address matches the adaptor
	- Or the destination address is the broadcast address
- Otherwise, adapter discards frame

Type: indicates the higher layer protocol
- Usually IP
- But also, Novell IPX, AppleTalk, … in early days

CRC: Cyclic Redundancy Check
- Checked at receiver
- If error is detected, the frame is simply dropped

##### Unreliable, connectionless service

Connectionless: No handshaking between sending and receiving adapter.

Unreliable
- Receiving adapter doesn’t send ACKs or NACKs
- Packets passed to network layer can have gaps
- Gaps will be filled if application is using TCP
- Otherwise, the application will see the gaps

##### Shuttling Data at different layers

Different devices switch different things
- Physical layer: electrical signals (repeaters and hubs)
- Link layer: frames (bridges and switches)
- Network layer: packets (routers)

Cut-through: Sending data packet through a switch as soon as the address is read and not reading the whole message.

**Plug-and-play (PnP)** in networking refers to the capability of devices to be automatically recognized and configured by a computer or network system when they are connected, without requiring manual intervention from the user.












<h6 style="font-weight: normal;">See Also</h6>

---

<h6 style="font-weight: normal;">References</h6>

---