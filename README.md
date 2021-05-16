# BFACP-DOCK [Battlefield Admin Control Panel](https://github.com/Prophet731/BFAdminCP)
```bash
# .env

DB_HOST=
DB_USER=
DB_PASS=
DB_NAME=
APP_KEY=
PUSHER_APP_ID=
PUSHER_APP_KEY=
PUSHER_APP_SECRET=
```
How to run:

```bash
docker run --env-file .env -p 9090:80 --name bfacp_docker bfacp_docker:latest
```
