#!/usr/bin/env python3
"""
GIMP 3.0 Python batch white balance
Usage: Run via gimp-console with python-fu-eval interpreter
"""

import sys
import gi
gi.require_version('Gimp', '3.0')
from gi.repository import Gimp, Gio

def process_image(input_path, output_path):
    """Process a single image with white balance"""
    # Load image
    input_file = Gio.file_new_for_path(input_path)
    image = Gimp.file_load(Gimp.RunMode.NONINTERACTIVE, input_file)

    # Get first layer
    layers = image.get_layers()
    if len(layers) == 0:
        print(f"Error: No layers in {input_path}")
        return False

    layer = layers[0]

    # Apply auto levels (white balance)
    Gimp.drawable_levels_stretch(layer)

    # Flatten and export
    image.flatten()
    layer = image.get_layers()[0]

    # Save
    output_file = Gio.file_new_for_path(output_path)
    Gimp.file_save(Gimp.RunMode.NONINTERACTIVE, image, output_file)

    # Cleanup
    image.delete()

    return True

if __name__ == "__main__":
    if len(sys.argv) != 3:
        print("Usage: script.py INPUT_PATH OUTPUT_PATH")
        sys.exit(1)

    input_path = sys.argv[1]
    output_path = sys.argv[2]

    success = process_image(input_path, output_path)
    sys.exit(0 if success else 1)
