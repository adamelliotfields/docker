# `mysql-client`
> _Docker image running Ubuntu 16.04 with `mysql-shell`, `mysql-utilities`, `sqlite3`, and `micro`._

This is a MySQL development environment in a container. It can be used to interact with your existing MySQL containers.

`mysql-shell` allows you to interact with your databases using SQL, JavaScript, or Python syntax. It is an enhancement over the basic client that ships with `mysql-server`.

`mysql-utilities` provides administrative tools for your MySQL databases, like replication.

`sqlite3` is included as a playground for running SQL commands.

`micro` is included as a powerful command-line text editor with syntax highlighting without needing to know Vim or Emacs.

### Supported tags and respective `Dockerfile` links
  - `latest`, `8.0.11` ([_Dockerfile_](https://github.com/adamelliotfields/docker/blob/master/mysql-client/Dockerfile))

### Usage

The default entrypoint is `mysql --sql`, which brings you to a prompt that accepts traditional SQL commands. `mysql` is a symlink of `mysqlsh` for convenience.

To switch back to the default JavaScript syntax mode, enter `\js` at the prompt. To exit the prompt, press `CTRL+D`.

You can also override the entrypoint by passing the `--entrypoint /bin/bash` flag.

To connect to a MySQL server, use the `\connect` command, i.e., `\connect <user>:<password>@<host>:<port>`.

If you are running your MySQL server in a Docker container connected to a _user-defined network_, you can use the container name as the host.

The `mysql-utilities` are run from the Bash prompt, not the MySQL Shell. If you're planning on importing/exporting `.sql` files, make sure you bind-mount a directory on your host to read/write from/to.
