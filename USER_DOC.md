# User Documentation

## What is running
This stack provides three services:
- NGINX: the public web entrypoint on port 443.
- WordPress: the website and administration panel.
- MariaDB: the database used by WordPress.

## Start and stop
From the root of the project:
```bash
make
```
This builds and starts everything.

To stop the containers without deleting the data:
```bash
make stop
```

If you want to start them again after stopping them:
```bash
make start
```

## Access the website
Add this line to your `/etc/hosts` file if it is not already there:
```text
127.0.0.1 aakroud.42.fr
```

Then open:
- https://aakroud.42.fr
- https://aakroud.42.fr/wp-admin

The browser will warn about the certificate because it is self-signed. That is expected.

## Credentials
The project keeps credentials in the `secrets/` folder:
- `secrets/db_password.txt`
- `secrets/db_root_pass.txt`
- `secrets/credentials.txt`

The general configuration is in `srcs/.env`.

## Check that everything is working
Useful commands:
```bash
make status
make logs
```

`make status` shows the containers, and `make logs` helps if something does not start correctly.
