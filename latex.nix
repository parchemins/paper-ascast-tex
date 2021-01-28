{ pkgs ? (import <nixpkgs> {}) }:

# curl https://raw.githubusercontent.com/NixOS/nixpkgs/tools/typesetting/tex/texlive/pkgs.nix

let usenix-latex = (pkgs.texlive.combine {
    inherit (pkgs.texlive)
    scheme-small
    collection-latex
    collection-latexextra
    collection-fontsextra
    collection-fontutils
    collection-mathscience
    fontawesome
    urlbst
    latexmk;
});

in pkgs.mkShell {
   # gs required for epstopdf in fontutils
   #   inputFrom = with pkgs; [ghostscript];
   buildInputs = with pkgs; [usenix-latex ghostscript];
}
