{ pkgs }:

{
  default = pkgs.mkShell {
    packages = [
  
    ];
    shellHook = ''
      echo -e "\e[45m Default dev shell activated \e[0m"
    '';
  };

  python = pkgs.mkShell {
    packages = with pkgs; [
      python312
      python312Packages.flake8
      python312Packages.black
    ];
    shellHook = ''
      echo -e "\e[45m Python dev shell activated \e[0m"
    '';
  };

  web = pkgs.mkShell {
    packages = [
      pkgs.nodejs
    ];
    shellHook = ''
      echo -e "\e[45m Web dev shell activated \e[0m"
    '';
  };

  cpp = pkgs.mkShell {
    packages = with pkgs; [
      gcc
      #clang
      
      #clang-tools # clang-tidy, clang-format
      cppcheck

      automake
      cmake
      gnumake
      ninja 

      # lldb
       gdb
      # gdbgui
      
      mpi
      mpich
    ];

    #CC = "${pkgs.clang}/bin/clang";
    #CXX = "${pkgs.clang}/bin/clang++";
    CFLAGS = "-Wall -Wextra -Werror";
    CXXFLAGS = "-Wall -Wextra -Werror";

    shellHook = ''
      echo -e "\e[45m C++ dev shell activated \e[0m"
    '';
  };

  java = pkgs.mkShell {
    packages = [
      pkgs.jdk
    ];
    shellHook = ''
      echo -e "\e[45m Java dev shell activated \e[0m"
    '';
  };

  nix = pkgs.mkShell {
    packages = with pkgs; [
      nix
      nixpkgs-fmt
    ];

    shellHook = ''
      echo -e "\e[45m Nix dev shell activated \e[0m"
    '';
  };
}
