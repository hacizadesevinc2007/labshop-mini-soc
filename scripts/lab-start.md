# Lab start / stop cheat sheet

## Start (in this order)
1. Power on **siem-host**.
2. On siem-host:
   ```bash
   cd ~/wazuh-docker/single-node
   docker compose ps          # all three should be Up (restart: always)
   ```
   If they are not up: `docker compose start`
3. Wait 1–2 minutes, open `https://10.10.10.10` from the Dell browser.
4. Power on **ubuntu-web**, then **win-client**. Agents turn Active.

## Stop (reverse order)
1. Shut down **win-client** and **ubuntu-web**.
2. On siem-host:
   ```bash
   cd ~/wazuh-docker/single-node
   docker compose stop        # NEVER: docker compose down -v  (deletes data volumes)
   sudo shutdown now
   ```

## Useful container commands
```bash
docker compose ps
docker compose logs -f wazuh.indexer      # when the indexer keeps restarting
docker stats --no-stream                  # memory per container
```
