{ pkgs ? import <nixpkgs> {} } :
let
  # lf = pkgs.callPackage ./nix/lf.nix {};
  # lingo = pkgs.callPackage ./nix/lingo.nix {};
in 
pkgs.mkShell {
  packages = with pkgs; [
    lolcat
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

  # set environment variables
  #PICO_BOARD = "pico";
  #PICO_PLATFORM = "rp2040";

  # TODO: integrate dependencies into nix
  shellHook = ''
    echo "[shell] hook start"
    echo "[shell] setup pico-sdk"
    git submodule update --init
    cd pico-sdk/
    git submodule update --init
    export PICO_SDK_PATH="$PWD"
    echo "[shell] PICO_SDK_PATH: $PICO_SDK_PATH" | lolcat
    cd ../
    echo "[shell] copy robot header (pololu_3pi_2040_robot.h)" | lolcat
    cp pololu_3pi_2040_robot.h pico-sdk/src/boards/include/boards/
    echo "[shell] PICO_BOARD: $PICO_BOARD" | lolcat
    echo "[shell] PICO_PLATFORM: $PICO_PLATFORM" | lolcat
    echo "[shell] setup testbed"
    cd test/
    npm install
    cd ../
    echo '[shell] To exit the shell, type `exit` or press `Ctrl`+`D`'
    echo "[shell] hook end"
    '';
}
