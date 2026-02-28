{ pkgs ? import <nixpkgs> {} } :
let
  # lf = pkgs.callPackage ./nix/lf.nix {};
  # lingo = pkgs.callPackage ./nix/lingo.nix {};
in 
pkgs.mkShell {
  packages = with pkgs; [
    picotool
    cmake
    gcc-arm-embedded
    openocd
    git
    nodejs
    zellij
    screen
    gdb
  ];
  buildInputs = [
    # lf
    # lingo
  ];
  
  PICO_BOARD_HEADER_DIRS = "";  # path to search for your own board configuration, if desired

  # TODO: integrate dependencies into nix
  shellHook = ''
    echo "[shell] hook start"
    echo "[shell] setup pico-sdk"
    git submodule update --init
    cd pico-sdk/
    git submodule update --init
    export PICO_SDK_PATH="$PWD"
    cd ../
    echo "[shell] setup testbed"
    cd test/
    npm install
    echo "[shell] hook end"
    cd ../
    '';
}
