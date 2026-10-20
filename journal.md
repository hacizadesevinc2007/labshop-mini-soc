# Journal

Format: what I tried → what failed → what fixed it.

## Week 1 — Build the lab and deploy Wazuh

### Entry 1 — Disk too small for Wazuh images
- **Tried:** pulling the Wazuh 4.14.7 images on siem-host.
- **Failed:** `no space left on device`. The VM disk was 256 GB, but the Ubuntu installer had created an LVM logical volume of only ~18 GB.
- **Fixed:** `growpart`, `pvresize` and `lvextend -r` → root is now ~251 GB.
- **Lesson:** check `df -h /` on the first day; LVM does not grow automatically.

### Entry 2 — Dashboard 401 after password change
- **Tried:** changing the default admin password (new hash in `internal_users.yml`, `INDEXER_PASSWORD` in `docker-compose.yml`, `securityadmin.sh`).
- **Failed:** the dashboard returned 401.
- **Fixed:** the password was different in the two places. Same value everywhere → login works, old default password rejected.
- **Lesson:** snapshot first, read the docs twice, change every location together.

### Entry 3 — Windows agent not connecting
- **Tried:** installing the agent on win-client with the MSI.
- **Failed:** the agent never showed up in the dashboard.
- **Fixed:** I had set `WAZUH_MANAGER` to win-client's own IP. Changed it to `10.10.10.10` → agent 002 Active.
- **Lesson:** the agent needs the manager's address and reachable ports 1514/1515.

### Entry 4 — Wrong time zone on Windows
- **Tried:** comparing clocks on all three machines.
- **Failed:** win-client was not on Asia/Baku, so alert timestamps did not line up.
- **Fixed:** `Set-TimeZone` → Asia/Baku (UTC+4). Linux VMs already had NTP synchronized.

### Entry 5 — Windows static IP without gateway
- **Tried:** a static IP on win-client with an empty default gateway.
- **Failed:** Windows would not accept the configuration.
- **Fixed:** set `10.10.10.1` (the laptop's host-only adapter). It does not route to the internet, so isolation (S2) is kept.

### Entry 6 — Sysmon noise
- **Tried:** reviewing Sysmon Event ID 1 in the dashboard.
- **Observed:** many process events had parent `wazuh-agent.exe` (the agent's own PowerShell/SecEdit checks).
- **Next:** filter this noise in a later week. A real test (`net user`) produced rule 92031 "Discovery activity executed", level 3.

### Entry 7 — Persistence test
- **Tried:** `docker compose stop/start`, then a full reboot of siem-host, then again with agents enrolled.
- **Observed:** containers restarted by themselves, `vm.max_map_count` and IPs persisted, both agents returned to Active, old alerts still searchable.
- **Lesson:** never use `docker compose down -v`.

### Entry 8 — Lab isolation
- **Tried:** removing the NAT adapter from ubuntu-web and win-client after software installation.
- **Observed:** `ip a` / `ipconfig` show only the 10.10.10.x lab address; agents still Active through siem-host.
