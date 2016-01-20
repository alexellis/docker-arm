## nginx\_dynamic\_x64

For a 64-bit computer, i.e. a regular PC/laptop.

- Builds upon the official Node.js image
- Adds Nginx package from apt repositories
- init.sh queries the swarm manager for containers with node_redis 
labels then generates a nginx.conf from a template to
