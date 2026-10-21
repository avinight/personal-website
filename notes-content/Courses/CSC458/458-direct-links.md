---
tags:
  - course/csc458
  - computer-science
---
Tags: #lecture

---
![[H03 CSC458.pdf]]
# 2.2 Encoding

Network adapter
	- a piece of hardware that connects a node to a link.

How to encode bits: Non-return to zero (NRZ). There are two problems. (related to consecutive 0s and 1s).

Baseline wander
	- the receiver keeps an average of the signal it has seen so far and then uses this average to distinguish between low and high signals
	- The problem, of course, is that too many consecutive 1s or 0s cause this average to change, making it more difficult to detect a significant change in the signal.

Clock recovery
- Clocks have to be synced for data to be sent/received correctly.
- When signal changes, then the receiver knows it is at a clock cycle boundary, and it can resynchronize itself.
- However, a long period of time without such a transition leads to clock drift. Thus, clock recovery depends on having lots of transitions in the signal, no matter what data is being sent.

Manchester Encoding
- The problem with the Manchester encoding scheme is that it doubles the rate at which signal transitions are made on the link, which means that the receiver has half the time to detect each pulse of the signal.

# 2.3 Framing

Frames
- blocks of data on packet-switched networks (not bit streams)
- complete link layer messages

BISYNC - Binary Synchronous Communication
DDCMP - Digital Data Communication Message Protocol
SYN - synchronization character
STX - start of text
ETX - end of text

sentinel characters indicate where frames start and end

The problem with the sentinel approach
- is that one of the special characters might appear in the data portion of the frame.

Solution: character stuffing
- “escaping” the character by preceding it with a DLE (data-link-escape) character whenever it appears in the body of a frame

Framing error
- 

# 2.4 Error Detection

## Internet Checksum Algorithm

I don't know how this works

```C
u_short
cksum(u_short *buf, int count)
{
    register u_long sum = 0;

    while (count--)
    {
        sum += *buf++;
        if (sum & 0xFFFF0000)
        {
            /* carry occurred, so wrap around */
            sum &= 0xFFFF;
            sum++;
        }
    }
    return ~(sum & 0xFFFF);
}
```

## Cyclic Redundancy Check

# 2.5 Reliable Transmission
---

### Sliding Window Algorithm

Sender assigns sequence number = `SeqNum` to each frame.
Sender maintains three variables:
- `SWS` - Send Window Size (upper bound on unacknowledged frames)
- `LAR` - Last Acknowledgement Received
- `LFS` - Last Frame Sent

Sender maintains invariant
- `LFS - LAR <= SWS`

Receiver maintains three variables:
- `RWS` - Receive Window Size
- `LAF` - Largest Acceptable Frame
- `LFR` - Last Frame Received

Receiver maintains invariant
- `LAF - LFR <= RWS`





# Lecture

### Physical/link layer
----
##### different types of media
---


##### encoding bits with signals
---
- network link
	- communication medium + network adapter (Network Interface Card or NIC)

- NRZ and NRZI
	- Simplest encoding, Non-return to zero / invert on 1 (NRZ / I)

- clock recovery
	- How do we distinguish consecutive 0s or 1s when sampling?
	- using a wire, lose an extra wire


2D Parity
- adds an extra row and column of parity bits to a given array of bits (in this case, binary digits).

	
- B x RTT
- checksums can fail when error is on same column
- 

<h6 style="font-weight: normal;">See Also</h6>

---

<h6 style="font-weight: normal;">References</h6>

---