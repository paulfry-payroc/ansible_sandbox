# 🧪 Ansible Sandbox

A lightweight **starter project** for learning and experimenting with **Ansible** locally — using Docker containers as disposable managed nodes.

This repo demonstrates a **clean baseline Ansible project structure** (with separate folders for playbooks, inventories, and roles), making it easy to evolve into a real-world automation repo later.

---

## ⚙️ What this sandbox sets up

When you complete the setup steps below, you’ll have:

* **Two local Docker containers (`node1`, `node2`)**
  → These act as simulated Ansible-managed hosts, letting you practise running playbooks against multiple systems.

* **An Ansible inventory (`inventories/dev/inventory.ini`)**
  → Defines the local containers as hosts in a “dev” environment group.

* **A sample playbook (`playbooks/site.yml`)**
  → A simple YAML file with example tasks (e.g., pinging hosts, creating files) so you can verify Ansible is working correctly.

* **A baseline folder structure (`playbooks/`, `roles/`, `inventories/`)**
  → Mirrors the layout used in production Ansible projects — helping you transition from sandbox to real deployments later.

All components are **local and disposable**, so you can safely experiment and tear them down with `make clean`.

---

## 🚀 Quick start

| **Step**                                     | **Command(s)** | **Description**                                                                                                                                                                                                                                                                                  |
| -------------------------------------------- | -------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| 🧩 **1. Install dependencies**               | `make deps`    | Installs the required Python dependencies (Ansible and related tools) using `pip`, and installs any collections listed in `requirements.yml`.                                                                                                                                                    |
| 🐳 **2. Create and prepare test containers** | `make install` | Creates two Ubuntu-based Docker containers (`node1`, `node2`) that act as managed hosts, installs Python inside each (required by Ansible modules), and ensures your inventory and playbook are in place.                                                                                        |
| ▶️ **3. Run the playbook**                   | `make run`     | Executes `playbooks/site.yml` against both containers listed in `inventories/dev/inventory.ini`. <br><br>To verify success, check for the created file on each node:<br>`docker exec -it node1 ls /tmp`<br>`docker exec -it node2 ls /tmp`<br>You should see `hello_ansible.txt` listed on both. |

---

✅ *After completing these steps, you’ll have a working local Ansible setup using Docker containers as managed hosts.*

---

## 🧹 Clean-up

When you’re done, remove the containers to restore your environment:

```bash
make clean
```

This stops and removes both containers (`node1`, `node2`).

---

## 🗂️ Project structure

Here’s the baseline repo layout used by this sandbox:

```
.
├── ansible.cfg
├── inventories/
│   └── dev/
│       ├── inventory.ini
│       ├── group_vars/
│       └── host_vars/
├── playbooks/
│   └── site.yml
├── roles/
│   └── README.md
├── requirements.yml
├── Makefile
├── README.md
└── src/
    ├── make/variables.mk
    └── sh/
        ├── create_docker_containers.sh
        ├── destroy_docker_containers.sh
        └── shell_utils.sh
```

This mirrors the **standard structure** used for scalable Ansible repositories — where:

| Folder           | Purpose                                                                 |
| ---------------- | ----------------------------------------------------------------------- |
| **inventories/** | Environment-specific inventories (e.g. `dev`, `prod`) and variables.    |
| **playbooks/**   | YAML playbooks that define automation workflows.                        |
| **roles/**       | Modular, reusable roles (e.g. `docker_runtime`, `airflow_single_node`). |
| **src/**         | Helper shell scripts and Make targets for local automation.             |

---

## 📘 Key Ansible Concepts

| Term          | Description                                                                      |
| ------------- | -------------------------------------------------------------------------------- |
| **Inventory** | Lists the hosts or groups of hosts that Ansible manages.                         |
| **Playbook**  | A YAML file describing one or more “plays” (task sets) run on defined hosts.     |
| **Role**      | A structured collection of tasks, files, templates, and vars designed for reuse. |
| **Module**    | A discrete unit of work (e.g. `ping`, `file`, `copy`, `yum`).                    |
| **Task**      | A single module invocation within a playbook.                                    |
| **Node**      | A target system that Ansible connects to and manages (your Docker containers).   |

---

## 🌱 Next steps / ideas for expansion

This sandbox provides a practical foundation for learning and iterating with Ansible.
Once you’re comfortable with the basics, consider expanding in the following directions:

1. **Add Variables & Templates**
   Use `vars:` blocks or external files to parameterise tasks and render dynamic content with Jinja2 templates.

2. **Introduce Roles**
   Move repeated logic into reusable, modular roles (e.g. `docker_runtime`, `airflow_single_node`).
   → See [docs/ansible_roles_example.md](docs/ansible_roles_example.md)

3. **Add Molecule tests**
   Use [Molecule](https://molecule.readthedocs.io/) to lint and test your roles automatically.

4. **Use Ansible Vault**
   Securely store credentials or secrets using `ansible-vault encrypt`.

5. **Integrate CI/CD**
   Add a lightweight pipeline (e.g. GitHub Actions or Azure DevOps) to run `ansible-lint` and playbook syntax checks on commit.

6. **Target remote hosts**
   Replace the local Docker setup with real VMs or EC2 instances (SSH-based connections) to practise managing actual infrastructure.
