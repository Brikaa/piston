{pkgs, piston, ...}:
let
    pkg = pkgs.python3;
in piston.mkRuntime {
    language = "python3";
    version = pkg.version;

    aliases = [
        "py3"
        "py"
        "python"
    ];

    run = ''
    PYTHONPATH=$PISTON_PACKAGES_PATH ${pkg}/bin/python3 "$@"
    '';

    packages = pkg.pkgs;

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
