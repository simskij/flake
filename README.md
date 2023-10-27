<div align="center">
  <h1>❄️</h1>
</div>

### What's this?

This is a flake that I use to configure my machines. It is meant to be an abstraction on top of the "raw" nixos
primitives that increase reusability while adding minimal maintenance overhead and duplication. This is done by
heavily using modules and options to create an opinionated configuration namespace available under `arctic`.

### Machines

| Hostname  | Model                    | OS     | Role    |
| --------- | :----------------------- | :----- | :------ |
| `juniper` | Ryzen 5950X Custom Build | NixOS  | Desktop |
| `spruce`  | Macbook Air M2           | MacOS  | Laptop  |

### Structure

| Path                 | Description                                     |
| :------------------- | :---------------------------------------------- |
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
