# language-example-container
A self contained language example git repository served through a docker container.

Use `docker run -d -p 2222:22 testeditor/git-examples` to start the container.
Use `git clone ssh://git@localhost:2222/git-server/repos/language-examples` to clone the language examples from that container. Make sure that you have the private key available (e.g. `ssh-add id_rsa`)

