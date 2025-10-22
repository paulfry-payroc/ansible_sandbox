# 🧩 Ansible — Introductory Overview

A quick guide to the **minimum files and flow** needed to understand how Ansible works.
This setup underpins everything you’ll do in the Ansible Sandbox.

---

## 🗂️ Minimum File Structure

The simplest working setup requires just two files:

```
ansible-sandbox/
├── inventory.ini
└── test_playbook.yml
```

### `inventory.ini`

Lists the hosts Ansible will manage and how to connect to them.

```ini
[nodes]
node1 ansible_connection=docker
node2 ansible_connection=docker
```

* `nodes` is a host group.
* Each host (e.g. `node1`) represents a managed node.
* The Docker connection lets Ansible communicate without SSH.

---

### `test_playbook.yml`

Defines what Ansible should do on those hosts.

```yaml
- name: Basic connectivity test
  hosts: nodes
  gather_facts: no
  tasks:
    - name: Ping all nodes
      ansible.builtin.ping:
```

* `hosts:` targets the group in the inventory.
* `tasks:` lists actions (each runs a module).
* The `ping` module verifies connectivity and Python availability.

---

## 🧠 How It Works (Simplified Flow)

1. **Run the playbook**

   ```bash
   ansible-playbook -i inventory.ini test_playbook.yml
   ```
2. **Read the inventory** — find which hosts to target.
3. **Connect** — use Docker (or SSH) to reach each host.
4. **Execute modules** — small Python scripts run remotely.
5. **Return results** — output shows which tasks changed or succeeded.
6. **Stay idempotent** — reruns make no changes if systems are already in the desired state.

---

### 💡 Summary

To run Ansible, you need only:

1. A control node with Ansible installed.
2. One or more reachable hosts (e.g. Docker containers).
3. An **inventory** describing them.
4. A **playbook** defining what to do.

Everything else in Ansible—roles, variables, templates, and CI/CD—builds on these same basics.
