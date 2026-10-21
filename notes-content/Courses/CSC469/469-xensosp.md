
Xen multiplexes physical resources at the granularity of an entire operating system
Xen provides protection isolation between these OSes.

Arguments against full virtualization:
-  desirable for the hosted operating systems to see real as well as virtual resources: providing both real and virtual time allows a guest OS to better support time-sensitive tasks
- Support for full virtualization was never part of the x86 architectural design.
- 

Paravirtualization
- A VM abstraction that 

We distill the discussion so far into a set of design principles:
1. Support for unmodified application binaries is essential, or users will not transition to Xen. Hence we must virtualize all architectural features required by existing standard ABIs.
2. Supporting full multi-application operating systems is important, as this allows complex server configurations to be virtualized within a single guest OS instance.
3. Paravirtualization is necessary to obtain high performance and strong resource isolation on uncooperative machine architectures such as x86.
4. Even on cooperative machine architectures, completely hiding the effects of resource virtualization from guest OSes risks both correctness and performance.