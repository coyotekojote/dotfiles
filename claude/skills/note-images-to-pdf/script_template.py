"""
Template for generating note-images-to-pdf scripts.
Customize COVER_PDF, OUTPUT_PDF, and IMAGE_URLS per task.
Run with: uv run --with Pillow --with pypdf --with requests <script>.py
"""

import requests
import tempfile
import os
from PIL import Image
from pypdf import PdfReader, PdfWriter

# === Customize these per task ===
COVER_PDF = ""  # Path to cover PDF (empty string = no cover)
OUTPUT_PDF = ""  # Output path, e.g. ~/Downloads/output.pdf
IMAGE_URLS = [
    # Paste image URLs here in order
]


def download_images(urls, dest_dir):
    paths = []
    for i, url in enumerate(urls):
        print(f"  Downloading image {i+1}/{len(urls)}...")
        resp = requests.get(url, timeout=30)
        resp.raise_for_status()
        path = os.path.join(dest_dir, f"img_{i:03d}.png")
        with open(path, "wb") as f:
            f.write(resp.content)
        paths.append(path)
    return paths


def image_to_pdf_page(image_path):
    """Convert an image to a single-page PDF, auto-rotating page to match image orientation."""
    img = Image.open(image_path)
    if img.mode == "RGBA":
        bg = Image.new("RGB", img.size, (255, 255, 255))
        bg.paste(img, mask=img.split()[3])
        img = bg
    elif img.mode != "RGB":
        img = img.convert("RGB")

    img_w, img_h = img.size
    is_landscape = img_w > img_h

    # A4 at 72 DPI - choose orientation to match image
    if is_landscape:
        page_w, page_h = 841.89, 595.28  # A4 landscape
    else:
        page_w, page_h = 595.28, 841.89  # A4 portrait

    # Scale to fill page as much as possible (small margin)
    margin = 10
    available_w = page_w - 2 * margin
    available_h = page_h - 2 * margin
    scale = min(available_w / img_w, available_h / img_h)
    new_w = int(img_w * scale)
    new_h = int(img_h * scale)
    img = img.resize((new_w, new_h), Image.LANCZOS)

    # Create canvas matching page orientation
    canvas = Image.new("RGB", (int(page_w), int(page_h)), (255, 255, 255))
    x = (int(page_w) - new_w) // 2
    y = (int(page_h) - new_h) // 2
    canvas.paste(img, (x, y))

    pdf_path = image_path.replace(".png", ".pdf")
    canvas.save(pdf_path, "PDF", resolution=72.0)
    return pdf_path


def main():
    with tempfile.TemporaryDirectory() as tmpdir:
        print("Downloading images...")
        image_paths = download_images(IMAGE_URLS, tmpdir)

        print("Converting images to PDF pages...")
        writer = PdfWriter()

        # Add cover PDF if specified
        if COVER_PDF:
            print("Adding cover page...")
            cover_reader = PdfReader(COVER_PDF)
            for page in cover_reader.pages:
                writer.add_page(page)

        # Add each image as a PDF page
        for i, img_path in enumerate(image_paths):
            print(f"  Converting image {i+1}/{len(image_paths)}...")
            pdf_path = image_to_pdf_page(img_path)
            page_reader = PdfReader(pdf_path)
            writer.add_page(page_reader.pages[0])

        print(f"Writing output to {OUTPUT_PDF}...")
        with open(OUTPUT_PDF, "wb") as f:
            writer.write(f)

        cover_count = len(PdfReader(COVER_PDF).pages) if COVER_PDF else 0
        print(f"Done! {cover_count} cover page(s) + {len(image_paths)} images = {len(writer.pages)} total pages")


if __name__ == "__main__":
    main()
