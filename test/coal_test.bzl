"""Macro mirroring the `add_coal_test()` CMake helper in test/CMakeLists.txt."""

load("@rules_cc//cc:cc_test.bzl", "cc_test")

def coal_test(name, timeout = None, extra_deps = [], **kwargs):
    """Declares a `coal-<name>` Boost.Test based unit test.

    Args:
        name: base name of the test; the source file is `<name>.cpp` and the
            resulting target is `coal-<name>`, matching the CMake target names.
        timeout: optional Bazel test timeout override (e.g. "eternal").
        extra_deps: extra `deps` beyond the coal library, test utility and
            Boost.Test/Boost.Filesystem.
        **kwargs: forwarded to `cc_test`.
    """
    cc_test(
        name = "coal-" + name,
        srcs = [name + ".cpp", ":gen_fcl_resources_config_hh"],
        deps = [
            ":utility",
            "//:coal",
            "@boost.assign",
            "@boost.filesystem",
            "@boost.test//:boost.test",
        ] + extra_deps,
        data = [":fcl_resources_data"],
        linkstatic = True,
        # Mirrors test/CMakeLists.txt's `include_directories(${CMAKE_CURRENT_BINARY_DIR})`:
        # generated fcl_resources/config.h is included as a package-relative
        # quoted path, so the package's bindir needs to be on the include path.
        includes = ["."],
        copts = select({
            "@platforms//os:windows": [],
            "//conditions:default": ["-Wno-c99-extensions"],
        }),
        timeout = timeout,
        **kwargs
    )
