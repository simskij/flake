<div align="center">
  <h1>❄️</h1>
  simskij's NixOS and home-manager configuration.
</div>




### Machines

Currently, I'm using this flake to configure the following machines.

| Hostname  | Model                    | OS     | Role    |
| --------- | ------------------------ | ------ | ------- |
| `juniper` | Ryzen 5950X Custom Build | NixOS  | Desktop |
| `spruce`  | Macbook Air M2           | MacOS  | Laptop  |

### Structure

| Path                 | Description                                     |
| -------------------- | ----------------------------------------------- |
| `.               `   |                                                 |
| `├─ hardware     `   | host-specific hardware configuration            |
| `├─ systems      `   | system and user configuration                   |
| `└─ modules      `   | abstraction of different configuration aspects  |
| `    ├─ base       ` | base configuration for all hosts                |
| `    ├─ apps       ` | options available under `arctic.apps`           |
| `    ├─ desktop    ` | options available under `arctic.desktop`        |
| `    ├─ homebrew   ` | options available under `arctic.homebrew`       |
| `    ├─ network    ` | options available under `arctic.network`        |
| `    ├─ packages   ` | options available under `arctic.packages`       |
| `    └─ settings   ` | options available under `arctic.settings`       |
