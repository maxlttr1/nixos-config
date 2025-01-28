# NixOS Configuration

Welcome to my NixOS configuration repository! This repository contains my personal NixOS setup, designed to be highly configurable and adaptable for different hosts. It leverages Nix Flakes, Home Manager, Disko, and various utilities to provide a flexible and powerful environment.

## Features

- **Nix Flakes**: Utilizes Nix Flakes for reproducible and declarative configuration.
- **Home Manager**: Manages user-specific configurations and dotfiles.
- **Disko**: Simplifies disk management and partitioning.
- **Various Utilities**: Includes a wide range of utilities and tools for development, gaming, system management, and more.

# NixOS Configuration

Welcome to my NixOS configuration repository! This repository contains my personal NixOS setup, designed to be highly configurable and adaptable for different hosts. It leverages Nix Flakes, Home Manager, Disko, and various utilities to provide a flexible and powerful environment.

## Features

- **Nix Flakes**: Utilizes Nix Flakes for reproducible and declarative configuration.
- **Home Manager**: Manages user-specific configurations and dotfiles.
- **Disko**: Simplifies disk management and partitioning.
- **Various Utilities**: Includes a wide range of utilities and tools for development, system management, and more.

## Getting Started

### Prerequisites

- Ensure you have Nix installed on your system. You can follow the [official Nix installation guide](https://nixos.org/download.html) for instructions.
- Enable Nix Flakes by adding the following to your Nix configuration 

### Cloning the Repository

Clone this repository to your local machine:

```sh
git clone https://github.com/yourusername/nixos-config.git
cd nixos-config
```

### Building and Applying the Configuration

To build and apply the configuration, use the following commands:

```sh
nix flake update
sudo nixos-rebuild switch --flake .#your-hostname
```

Replace `your-hostname` with the appropriate hostname defined in the Flake configuration.


## Contributing

Contributions are welcome! If you have any suggestions, improvements, or bug fixes, please open an issue or submit a pull request.

## Acknowledgments

- Thanks to the NixOS community for their excellent documentation and support.
- Inspiration and ideas from various NixOS configuration repositories on GitHub.
