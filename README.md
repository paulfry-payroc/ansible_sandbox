# 🧪 Ansible Sandbox

A small, role-based **local Ansible environment** using Docker.
Built for quick testing and safe experimentation — with almost nothing to remember.

---

# ⚡ TL;DR — The only commands you need

```bash
make deps
```

➡️ Installs Ansible (one-time).

```bash
make install
```

➡️ Creates Docker node **node1**, exposes nginx on **[http://localhost](http://localhost)**, prepares it for Ansible.

```bash
make run
```

➡️ Applies the `webserver` role, installing nginx and serving a test page.

Then visit:

**[http://localhost](http://localhost)**

You should see:

```
Hello from the Ansible sandbox webserver role!
```

```bash
make clean
```

➡️ Removes the sandbox container.

---

## 🚀 Quick overview (no commands repeated)

* The sandbox uses **one Docker container** (`node1`).
* The inventory defines a `nodes` group for easy extension.
* The main playbook (`playbooks/site.yml`) applies roles.
* The example role (`roles/webserver`) installs nginx.
* Port **80** inside the container is exposed directly to your host.

That’s it — minimal, predictable, and easy to pick back up later.

---

## 🗂️ Project structure

```
inventories/dev/inventory.ini   # defines node1
playbooks/site.yml              # applies roles
roles/webserver/                # example nginx role
src/sh/*.sh                     # container create/destroy helpers
Makefile                        # top-level automation
```

---

## 📝 How it works (30 seconds)

* `make install` → spins up an Ubuntu container with port 80 published
* `make run` → runs Ansible, which installs & configures nginx via the `webserver` role
* You hit `http://localhost` → the page is served from inside `node1`
