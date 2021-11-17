## Ditfiles

### Installing

<!-- Use [GNU Stow](https://www.gnu.org/software/stow) -->

<!-- The `--no-folding` option for stow is set by default in `.stowrc`. -->
<!-- This means that instead of descending as low as possible in a stow directory to symlink, stow will descend all the way. -->
<!-- This allows the created directories to be used by other programs without polluting this repo. -->
<!-- Also the default target directory is set to `$HOME`. Edit or remove `.stowrc` to change these options. -->
- Install ansible
- To change default variables 
    - `cp vars/default.yml vars/vars.yml`
    - Change the variables in `vars/vars.yml` (leave `default.yml` alone)
- `ansible-playbook playbook.yml`


<!-- TODO -->
### Programs

The `programs` list is incomplete and does not include versions.


### Bash

Existing `.bashrc` and `.bash_profile` files are backed up
Add a `.secrets` file in `bash/.config/bash` with secret env vars to be sourced at startup.


### Inputrc

According to the [readline docs](https://man7.org/linux/man-pages/man3/readline.3.html), the `INPUTRC` env var
should change the location of the readline config but for some inexplicable reason this does not work so its staying in `$HOME`
