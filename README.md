# gimp-utils

GIMP utilities for batch image processing

Created by [@jontsai](https://github.com/jontsai) | Part of [Hacktoolkit](https://github.com/hacktoolkit)

## Overview

A collection of minimal, Unix-philosophy CLI utilities for automated image processing using GIMP's headless mode and Script-Fu.

Following the Unix philosophy:
- Each tool does one thing well
- Tools use stdin/stdout and can be composed
- Minimal arguments to memorize
- Clear help messages when invoked incorrectly

## Installation

Clone the repo and add scripts to your PATH, or run directly:

```bash
git clone https://github.com/hacktoolkit/gimp-utils.git
cd gimp-utils
```

Optional: Add to your PATH
```bash
export PATH="$PATH:$HOME/code/gimp-utils"
```

## Available Tools

### gimp-white-balance

Apply auto white balance (Colors > Auto > White Balance) to images in batch.

**Before & After Examples:**

*Example images courtesy of [@SkilletzCafe](https://github.com/SkilletzCafe)*

<table>
<tr>
<td><b>Before (Raw)</b></td>
<td><b>After (White Balanced)</b></td>
</tr>
<tr>
<td><img src="https://raw.githubusercontent.com/hacktoolkit/gimp-utils/master/examples/white-balance/tearekz_boba_sundae_raw.jpg" width="400" alt="Boba sundae before white balance"></td>
<td><img src="https://raw.githubusercontent.com/hacktoolkit/gimp-utils/master/examples/white-balance/tearekz_boba_sundae_white_balanced.jpg" width="400" alt="Boba sundae after white balance"></td>
</tr>
<tr>
<td><img src="https://raw.githubusercontent.com/hacktoolkit/gimp-utils/master/examples/white-balance/tearekz_dalgona_raw.jpg" width="400" alt="Dalgona before white balance"></td>
<td><img src="https://raw.githubusercontent.com/hacktoolkit/gimp-utils/master/examples/white-balance/tearekz_dalgona_white_balanced.jpg" width="400" alt="Dalgona after white balance"></td>
</tr>
</table>

**Usage:**
```bash
gimp-white-balance INPUT_DIR OUTPUT_DIR [PATTERN]
```

**Arguments:**
- `INPUT_DIR` - Directory containing source images
- `OUTPUT_DIR` - Directory where processed images will be saved (created if it doesn't exist)
- `PATTERN` - File pattern to match (default: `*.JPG`)

**Examples:**
```bash
# Process all JPG files
./gimp-white-balance ./photos ./processed

# Process PNG files
./gimp-white-balance ./photos ./processed "*.png"

# Process with absolute paths
./gimp-white-balance ~/Pictures/unprocessed ~/Pictures/processed

# Process all image types
./gimp-white-balance ./raw ./output "*.{jpg,JPG,png,PNG}"
```

**Output:**
The script will:
1. Find all matching files in INPUT_DIR
2. Show progress with checkmarks (✓ success, ✗ failure)
3. Save processed images to OUTPUT_DIR with the same filenames

## Requirements

- GIMP 3.0+ installed at `/Applications/GIMP.app` (macOS)
- Script-Fu support (built into GIMP)
- Bash shell

**Platform Support:**
- Currently supports macOS only
- Linux/Windows support coming soon (contributions welcome!)

**Installation Notes:**
- The script expects GIMP to be installed at the standard macOS location: `/Applications/GIMP.app`
- If GIMP is installed elsewhere, edit the script and update the path on line 69

## Notes

- **GIMP 3.0 Compatibility**: These scripts use GIMP 3.0's Script-Fu v3 API
- **Non-destructive**: Original files are never modified
- **Progress indicator**: Real-time feedback shows which files succeeded/failed
- **Error handling**: Continues processing remaining files even if one fails

## Technical Details

This tool uses GIMP's batch mode with Script-Fu v3 dialect to process images without GUI overhead. Each image is:
1. Loaded in non-interactive mode
2. Auto white balance applied using `gimp-drawable-levels-stretch`
3. Flattened to a single layer
4. Saved to the output directory

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

Areas for contribution:
- Linux support (detecting GIMP installation paths)
- Windows support
- Additional image processing utilities
- Performance improvements

## Credits

Created and maintained by [@jontsai](https://github.com/jontsai)

Sponsored by [@hacktoolkit](https://github.com/hacktoolkit)

## License

MIT License - see [LICENSE](LICENSE) file for details
