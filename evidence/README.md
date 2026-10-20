# Evidence index

Each screenshot and the one thing it proves.

## lab/
| File | Proves |
|---|---|
| 01-siem-host-vm-settings.png | siem-host has 16 GB RAM, 6 CPUs, 256 GB disk, VMnet2 + VMnet8 (L1) |
| 02-ubuntu-web-vm-settings.png | ubuntu-web has 2 GB RAM, 2 CPUs, 40 GB disk (L1, taken during setup) |
| 03-win-client-vm-settings.png | win-client has 4 GB RAM, 2 CPUs, 80 GB disk (L1, taken during setup) |
| 04-siem-host-ip-and-ping.png | siem-host is 10.10.10.10 and reaches both endpoints (L2, L3) |
| 05-ubuntu-web-ip-and-ping.png | ubuntu-web has only the lab interface 10.10.10.50 and reaches the others (L2, L3, S2) |
| 06-win-client-ipconfig-and-ping.png | win-client has only the lab address 10.10.10.80 and reaches the others (L2, L3, S2) |
| 07-dell-host-ping.png | the laptop reaches all three VMs (L3) |
| 08-clocks-synchronized.png | clocks are Asia/Baku and synchronized (L3) |
| 09-docker-and-max-map-count.png | Docker 29.9.1, Compose v5.6.0, vm.max_map_count = 262144 (L4) |

## wazuh/
| File | Proves |
|---|---|
| 10-compose-ps-4.14.7.png | three Wazuh 4.14.7 containers are Up (W1) |
| 11-certificate-warning.png | self-signed certificate warning (W2) |
| 12-dashboard-home.png | dashboard opens over HTTPS from the laptop (W2, L3) |
| 13-default-password-rejected.png | the default admin password no longer works (W3) |
| 14-compose-stop-start.png | stack stopped and started without deleting volumes (W4) |
| 15-manager-status-after-restart.png | manager v4.14.7 healthy after restart (W4) |
| 16-after-reboot-containers-up.png | after reboot: containers Up, sysctl and IPs persisted (W4, L4) |
| 17-reboot-uptime-proof.png | host uptime 22 min, containers created 17 h ago (W4) |
| 18-agents-active-after-reboot.png | both agents Active after reboot (W4) |
| 19-memory-first-measurement.png | memory per container at start-up (W5) |
| 20-memory-idle-measurement.png | memory per container when idle (W5) |

## agents/
| File | Proves |
|---|---|
| 21-ubuntu-web-agent-install.png | agent 4.14.7 installed and running on ubuntu-web (A1) |
| 22-ubuntu-web-agent-active.png | ubuntu-web (001) Active in dashboard (A1) |
| 23-win-client-agent-install.png | agent installed on win-client, WazuhSvc Running (A2) |
| 24-two-agents-active.png | ubuntu-web and win-client both Active (A1, A2) |
| 25-sysmon-install.png | Sysmon installed with SwiftOnSecurity config, agent restarted (A3) |
| 26-sysmon-events-dashboard.png | Sysmon Event ID 1 reaches the dashboard from win-client (A3) |
| 27-apache-ssh-running.png | apache2 and ssh running on ubuntu-web (A4) |
| 28-apache-default-page-from-dell.png | Apache default page opens from the laptop (A4) |

## verification/
| File | Proves |
|---|---|
| 29-failed-ssh-login.png | failed SSH login → rule 5760, level 5 (V1 #1) |
| 30-sudo-and-new-user.png | sudo → 5402 level 3; new user → 5902 level 8 (V1 #2, #3) |
| 31-sysmon-net-user-event.png | `net user` seen by Sysmon on win-client (V1 #4) |
| 32-sysmon-net-user-rule.png | rule 92031 "Discovery activity executed", level 3 (V1 #4) |
| 33-failed-windows-logon-event.png | Event ID 4625 for unknown user `yoxdur` (V1 #5) |
| 34-failed-windows-logon-rule.png | rule 60122 "Logon Failure", level 5 (V1 #5) |
