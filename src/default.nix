{ pkgs, lib, pkg-config }:

let
  manifest = (pkgs.lib.importTOML ../Cargo.toml).package;
in
{
  ldknode = pkgs.rustPlatform.buildRustPackage rec {
    pname = manifest.name;
    inherit (manifest) version;
    src = ../.;
    cargoLock.lockFile = ../Cargo.lock;

    nativeBuildInputs = [
      pkg-config
    ];
    buildInputs = [ pkgs.openssl ];
  };

}
