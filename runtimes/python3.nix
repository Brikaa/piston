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
    FIRST_PATH="''${PISTON_PACKAGES_PATH%%:*}"
    PYTHON_LIB=$(ls $FIRST_PATH/lib | head -n1)
    # include /lib/pythonx.x/site-packages after each path
    PYTHONPATH="''${PISTON_PACKAGES_PATH//://lib/$PYTHON_LIB/site-packages:}/lib/$PYTHON_LIB/site-packages" ${pkg}/bin/python3 "$@"
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
