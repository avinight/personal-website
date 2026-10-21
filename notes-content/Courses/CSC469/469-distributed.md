
Cristian Algorithm is good when you have a trusted source
Berkeley Algorithm good for P2P networks, no authoritative source
NTP for scalability

time sharing protocols must be scaled carefully otherwise we may have a denial of service problem like in NetGear DDOS.

PTP used in data centers, finances, control systems. Best master clock algoirthm, grand master clock. Boundary clock. Exact time is not really matter over ordering of distributed events.

Ordering could come from possible influence rather than a clock read. No longer looking at a clock to infer ordering, rather using a causal argument

Safety / Liveness
- Safety: some bad thing will never happen

- Liveness is a progress property: some good thing will eventually happen

Timing model