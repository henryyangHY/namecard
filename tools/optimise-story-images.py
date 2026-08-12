#!/usr/bin/env python3
"""Resize and re-encode the story page photographs for the web.

Drop the full-size originals into images/story/ under the names listed in
content/story.md, then run this from the repo root:

    pip install Pillow
    python3 tools/optimise-story-images.py

Every file is resized to fit LONG_EDGE and re-encoded in place. The
spreadsheet is exempt: readers are meant to zoom into it, so it keeps its
resolution and only gets a lossless squeeze.

Pass --dry-run to see what would change without writing anything.
"""

import sys
from pathlib import Path

from PIL import Image, ImageOps

STORY_DIR = Path(__file__).resolve().parent.parent / "images" / "story"

LONG_EDGE = 1600
JPEG_QUALITY = 80

# Meant to be opened and zoomed, so it keeps its pixels.
FULL_RES = {"07-inventory-spreadsheet.png"}


def optimise(path: Path, dry_run: bool) -> str:
    before = path.stat().st_size
    with Image.open(path) as im:
        # Phone photos carry rotation in EXIF; bake it in before resizing so
        # the saved file is not silently sideways once the tag is dropped.
        im = ImageOps.exif_transpose(im)

        if path.name in FULL_RES:
            resized = ""
        else:
            im.thumbnail((LONG_EDGE, LONG_EDGE), Image.LANCZOS)
            resized = f", {im.width}x{im.height}"

        if dry_run:
            return f"{path.name}: {before // 1024} KB{resized} (dry run)"

        if path.suffix.lower() in {".jpg", ".jpeg"}:
            im.convert("RGB").save(
                path, "JPEG", quality=JPEG_QUALITY, optimize=True, progressive=True
            )
        else:
            im.save(path, optimize=True)

    after = path.stat().st_size
    saved = 100 - (after * 100 // before) if before else 0
    return f"{path.name}: {before // 1024} KB -> {after // 1024} KB (-{saved}%){resized}"


def main() -> int:
    dry_run = "--dry-run" in sys.argv

    if not STORY_DIR.is_dir():
        print(f"nothing to do: {STORY_DIR} does not exist yet")
        return 0

    images = sorted(
        p
        for p in STORY_DIR.iterdir()
        if p.suffix.lower() in {".jpg", ".jpeg", ".png"}
    )
    if not images:
        print(f"nothing to do: no images in {STORY_DIR}")
        return 0

    for path in images:
        print(optimise(path, dry_run))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
