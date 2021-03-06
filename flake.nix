{
  description = ''Nim module for parsing ITN (TomTom intinerary) files'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs."itn-master".dir   = "master";
  inputs."itn-master".owner = "nim-nix-pkgs";
  inputs."itn-master".ref   = "master";
  inputs."itn-master".repo  = "itn";
  inputs."itn-master".type  = "github";
  inputs."itn-master".inputs.nixpkgs.follows = "nixpkgs";
  inputs."itn-master".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@inputs:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib"];
  in lib.mkProjectOutput {
    inherit self nixpkgs;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
    refs = builtins.removeAttrs inputs args;
  };
}