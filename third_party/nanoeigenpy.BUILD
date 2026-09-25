load("@bazel_skylib//rules:copy_file.bzl", "copy_file")
load("@rules_cc//cc:cc_library.bzl", "cc_library")

package(default_visibility = ["//visibility:public"])

licenses(["notice"])  # BSD-3-Clause

# See third_party/nanoeigenpy_config.hpp for why this is a copy rather than
# an expand_template.
copy_file(
    name = "gen_config_hpp",
    src = "@@//:third_party/nanoeigenpy_config.hpp",
    out = "include/nanoeigenpy/config.hpp",
)

# nanoeigenpy is used by coal's nanobind Python bindings (//python-nb) only
# for its header-only helpers (nanoeigenpy::IdVisitor, exposeQuaternion,
# exposeAngleAxis); its own compiled Python module (src/module.cpp) and
# CHOLMOD/Accelerate-specific decomposition headers are not needed and are
# not built here.
cc_library(
    name = "nanoeigenpy",
    hdrs = glob(["include/nanoeigenpy/**/*.hpp"]) + [":gen_config_hpp"],
    includes = ["include"],
    deps = ["@eigen"],
)
