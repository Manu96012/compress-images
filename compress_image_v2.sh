#!/bin/sh

show_help() {
    echo "Usage: $0 [OPTIONS] IMAGE_OR_DIRECTORY [DESTINATION_EXTENSION]"
    echo
    echo "A simple script to compress images (or a directory of images) using sips on macOS."
    echo
    echo "Options:"
    echo "  -h, --help        Show this help message and exit."
    echo
    echo "Arguments:"
    echo "  IMAGE_OR_DIRECTORY   The image file or directory containing images to compress."
    echo "  DESTINATION_EXTENSION (optional) The image extension for the compressed images. If not specified, the original extension will be used."
    echo
    echo "Accepted Formats by sips:"
    echo "  - JPEG (.jpg, .jpeg)"
    echo "  - PNG (.png)"
    echo "  - TIFF (.tiff, .tif)"
    echo "  - GIF (.gif)"
    echo "  - BMP (.bmp)"
    echo "  - ICO (.ico)"
    echo "  - JPEG 2000 (.jp2, .j2k)"
    echo "  - HEIF (.heif, .heic)"
    echo
    echo "Example Usage:"
    echo "  $0 image.jpg         Compress a single image with the same format (JPEG)."
    echo "  $0 images/           Compress all images in the 'images' directory."
    echo "  $0 images/ png       Compress all images in 'images' directory into PNG format."
    echo
    echo "Notes:"
    echo "  - If a directory is passed, all files in the directory will be processed."
    echo "  - The script creates a 'compressed' directory with subdirectories for each destination extension."
}

# Check for help flag

compress_and_save() {
	# Source image
	source_image="$1"
	# Destination extension
	destination_image_extension="$2"
	# Absolute path of the source image
	source_image_absolute_path="$(realpath $1)"
	# Extension of the source image
	source_image_extension="${source_image##*.}"
	# Filename of the source image
	source_image_filename="$(basename $source_image_absolute_path .$source_image_extension)"
	# Path to the folder containing the source image
	path_to_source_image_folder="$(realpath $(dirname $source_image_absolute_path))"
	# New name for the compressed images folder
	new_folder_name="compressed"

				# If no extension is specified, keep the same as the source image for compression
	if [ "$destination_image_extension" = "" ]; then
		destination_image_extension=$source_image_extension
	fi

	if [[ ! -d "${path_to_source_image_folder}/${new_folder_name}/${destination_image_extension}" ]]; then
		mkdir -p "${path_to_source_image_folder}/${new_folder_name}/${destination_image_extension}"
	fi

	# Compress the image with the following legend: source_image.png -> source_image_compressed.<desired_extension>
	sips -s format $destination_image_extension -s formatOptions low $source_image_absolute_path --out "${path_to_source_image_folder}/${new_folder_name}/${destination_image_extension}/${source_image_filename}_compressed.${destination_image_extension}"
}

if [[ "$1" == "-h" || "$1" == "--help" ]]; then
    show_help

elif [ $# -gt 0 ]; then
	if [[ -f "$1" ]]; then
		echo "You passed a file"
		compress_and_save $1 $2

	elif [[ -d "$1" ]]; then
		echo "You passed a folder"

		for _file in $1*; do
			if [[ -f "$_file" ]]; then
				compress_and_save $_file $2

			else
				echo "Skipping ${_file} as it is not a file"

			fi
		done
	else
		echo "What are you passing...?"

	fi
else
	show_help

fi

exit 0
