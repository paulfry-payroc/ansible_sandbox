# 🧱 Example: Breaking Playbooks into Reusable Roles

As your playbooks grow, repeating tasks across multiple files becomes difficult to manage.
**Roles** solve this by organising related tasks, files, and variables into a standard structure that can be reused across projects.

---

## 🗂️ Example Folder Structure

```
ansible-sandbox/
├── inventory.ini
├── playbooks/
│   └── site.yml
└── roles/
    └── ping_test/
        └── tasks/
            └── main.yml
```

**Explanation:**

* `roles/ping_test/tasks/main.yml` → contains the logic for the reusable role.
* `playbooks/site.yml` → the top-level playbook that calls one or more roles.
* Roles can also include optional subfolders such as `files/`, `templates/`, `vars/`, or `handlers/`.

---

## 🧩 Role Definition (`roles/ping_test/tasks/main.yml`)

```yaml
---
# roles/ping_test/tasks/main.yml

- name: Ping all nodes
  ansible.builtin.ping:

- name: Create a test file
  ansible.builtin.file:
    path: /tmp/hello_ansible_from_role.txt
    state: touch
```

This role replicates the tasks from your original `test_playbook.yml`, but makes them reusable in other playbooks.

---

## ▶️ Playbook That Calls the Role (`playbooks/site.yml`)

```yaml
---
# playbooks/site.yml

- name: Run ping_test role
  hosts: nodes
  gather_facts: no
  roles:
    - ping_test
```

This short playbook includes the `ping_test` role and applies it to all hosts in the `nodes` group.

---

## 🧠 How It Works

1. The `roles:` section tells Ansible to look for a matching folder under `roles/`.
2. Ansible automatically loads and executes the tasks in `roles/ping_test/tasks/main.yml`.
3. The same role can be reused in other playbooks or projects by referencing `ping_test`.

---

## 🧪 Run It

From your sandbox root directory:

```bash
ansible-playbook -i inventory.ini playbooks/site.yml
```

Verify the results:

```bash
docker exec -it node1 ls /tmp/
docker exec -it node2 ls /tmp/
```

You should see `/tmp/hello_ansible_from_role.txt` created by the role.

---

## ✅ Benefits of Using Roles

| Benefit          | Description                                                                                                                     |
| ---------------- | ------------------------------------------------------------------------------------------------------------------------------- |
| **Reusability**  | Common task logic lives once in a role, not repeated in multiple playbooks.                                                     |
| **Organisation** | Roles keep your Ansible structure modular and predictable.                                                                      |
| **Scalability**  | Teams can maintain separate roles (e.g. `database`, `webserver`, `monitoring`) and combine them as needed in a single playbook. |
