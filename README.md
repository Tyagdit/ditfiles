## Ditfiles

### Installing

- Install [ansible](https://docs.ansible.com/ansible/latest/installation_guide/index.html)
- To change default variables
    - `cp vars/default.yml vars/vars.yml`
    - Change the variables in `vars/vars.yml` (leave `default.yml` alone)
- `ansible-playbook playbook.yml`

NOTE: If you have an existing environment in place, stuff might break


### Bash

Existing `.bashrc` and `.bash_profile` files are backed up
Add a `.secrets` file in `bash/.config/bash` with secret env vars to be sourced at startup.


### Inputrc

According to the [readline docs](https://man7.org/linux/man-pages/man3/readline.3.html), the `INPUTRC` env var
should change the location of the readline config but for some inexplicable reason this does not work so its staying in `$HOME`
