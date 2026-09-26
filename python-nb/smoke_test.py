"""Minimal Bazel smoke test for the nanobind bindings (//python-nb:coal).

There is no existing test suite for these bindings to mirror (unlike the
legacy Boost.Python bindings' test/python_unit/); this just checks that the
extension imports and that a basic collision check works end to end.
"""

import coal


def test_import_and_collide():
    assert coal.__version__

    box1 = coal.Box(1.0, 1.0, 1.0)
    box2 = coal.Box(1.0, 1.0, 1.0)
    t1 = coal.Transform3s()
    t2 = coal.Transform3s()

    request = coal.CollisionRequest()
    result = coal.CollisionResult()
    num_contacts = coal.collide(box1, t1, box2, t2, request, result)
    assert num_contacts > 0
    assert result.isCollision()


if __name__ == "__main__":
    test_import_and_collide()
    print("OK")
