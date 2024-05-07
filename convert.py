import os
from PIL import Image

def deal_png_at_location(root):
    for root, dirs, files in os.walk(root):
        for file in files:
            if file.endswith(".png"):
                img_path = os.path.join(root, file)
                img = Image.open(img_path)
                # whether this file is an 8-bit png, skip it if not
                # if img.mode != "P":
                #     continue
                img = img.convert("RGBA")
                img.save(img_path)

deal_png_at_location("./")
