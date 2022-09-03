{pkgs, piston, packages ? [ ], ...}:
let
    basePkg = pkgs.python3;
    pkg = basePkg.withPackages (p: pkgs.lib.lists.forEach packages (x: p.${x}));
in piston.mkRuntime {
    language = "python3";
    version = basePkg.version;

    aliases = [
        "py3"
        "py"
        "python"
    ];

    run = ''
    ${pkg}/bin/python3 "$@"
    '';

    tests = [
        (piston.mkTest {
            files = {
                "test.py" = ''
                    print("OK")
                '';
            };
        })
    ];
}
