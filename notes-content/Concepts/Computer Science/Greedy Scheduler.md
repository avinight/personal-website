---
tags:
  - computer-science
---

Total available space is the same as finding the distance between two points on a line. [[Length of a vector]]

1. Parcels will be chosen in non-increasing destination
2. Trucks will be chosen in order or most available space.
3. Find the trucks that have enough unused volume for our parcel.
5. Among those trucks, if there are any that already have the parcel's desitnation at the end of their route, only those trucks are considered. 


`available_truck_1` denotes parcels going to most available space.
`available_truck_2` denotes which trucks have the same destination as parcels at the end of their route, so those are the only ones considered.