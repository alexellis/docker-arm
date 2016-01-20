## nginx\_dynamic

This is an arm image for Raspberry PI etc.

- Installs Node.js 4.x from binary redist
- Adds Nginx package from apt repositories
- init.sh queries the swarm manager for containers with node_redis 
labels then generates a nginx.conf from a template to


