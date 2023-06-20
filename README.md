# docker-vite

A template project developed using Vite on Docker container.

## How to use

1. You clone this repository on your environment for development.
2. Please execute scripts as follows:
  1. `sh setup-1-create-project.sh`
    1. You have to input a project name,
    2. You should select a application framework: Vue, React, Vanilla, etc.
    3. Then, you select a programming language: TypeScript, JavaScript, etc.
  2. Edit `setup-2-mod-yml.sh`, and type a project name into PROJECT=<your project name>
  3. `sh setup-2-mod-yml.sh`
  4. `sh setup-3-rebuild.sh`
3. If you'd like to reset files, you execute `sh reset.sh`

