# Address table

| Name | Role | OS | IP (VMnet2) | RAM | vCPU | Disk | Network adapters |
|---|---|---|---|---|---|---|---|
| siem-host | Wazuh 4.14.7 in Docker | Ubuntu Server LTS | 10.10.10.10 | 16 GB | 6 | 256 GB | VMnet2 (host-only) + VMnet8 (NAT, permanent) |
| ubuntu-web | Linux endpoint, Apache2, SSH | Ubuntu Server LTS | 10.10.10.50 | 2 GB | 2 | 40 GB | VMnet2 only (NAT removed after setup) |
| win-client | Windows endpoint, Sysmon | Windows 10 | 10.10.10.80 | 4 GB | 2 | 80 GB | VMnet2 only (NAT removed after setup) |
| Dell (host) | Hypervisor, browser | Windows | 10.10.10.1 | 32 GB total | — | 1 TB | VMnet2 host adapter (no routing) |

- Lab network: VMnet2, host-only, `10.10.10.0/24`
- All addresses are static.
- Total RAM given to VMs: 22 GB (10 GB left for the host; Week 3 adds a 2 GB attacker VM).
- win-client uses `10.10.10.1` as default gateway because Windows did not accept the static configuration without one. It is the host-only adapter of the Dell, not a router, so there is no route to the internet.

![Lab diagram](lab-diagram.png)
