let
  dirReq = import ./imp/dirRec.nix;
  filterFiles = import ./common/filterFiles.nix;
  dir = ./imp;
in
  dirReq.imp {
    inherit dir;
    structured = true;
  }
