#!/usr/bin/env python3
"""Make copied XCFramework links portable; reject dangling or escaping links."""
import os
import sys
from pathlib import Path


def normalize(root):
    root = Path(root).resolve(strict=True)
    links = [path for path in root.rglob('*') if path.is_symlink()]
    replacements = []
    for path in links:
        target = os.readlink(path)
        if os.path.isabs(target):
            marker = '/' + root.name + '/'
            if marker not in target:
                raise ValueError(f'External symlink: {path} -> {target}')
            suffix = target.rsplit(marker, 1)[1]
            candidate = Path(os.path.abspath(root / suffix))
            if root not in candidate.parents:
                raise ValueError(f'Escaping symlink: {path} -> {target}')
            replacements.append((path, os.path.relpath(candidate, path.parent)))
    for path, target in replacements:
        path.unlink()
        path.symlink_to(target)
        print(f'Normalized {path.relative_to(root)} -> {target}')
    for path in links:
        target = path.resolve(strict=True)
        if target != root and root not in target.parents:
            raise ValueError(f'External symlink: {path} -> {target}')


if __name__ == '__main__':
    normalize(sys.argv[1])
