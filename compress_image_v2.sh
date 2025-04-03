#!/bin/sh

compress_and_save() {
	# Immagine sorgente
	source_image="$1"
	# Estensione di destinazione
	destination_image_extension="$2"
	# Path assoluto dell'immagine sorgente
	source_image_absolute_path="$(realpath $1)"
	# Estensione dell'immagine sorgente
	source_image_extension="${source_image##*.}"
	# Filename dell'immagine sorgente
	source_image_filename="$(basename $source_image_absolute_path .$source_image_extension)"
	# Path per la cartella contente l'immagine sorgente
	path_to_source_image_folder="$(realpath $(dirname $source_image_absolute_path))"
	# Nuovo nome della folder delle immagini compresse
	new_folder_name="compressed"

				# Se non ho specificato un'estensione, lascio la medesima dell'immagine sorgente per la compressione
	if [ "$destination_image_extension" = "" ]; then
		destination_image_extension=$source_image_extension
	fi

	if [[ ! -d "${path_to_source_image_folder}/${new_folder_name}/${destination_image_extension}" ]]; then
		mkdir -p "${path_to_source_image_folder}/${new_folder_name}/${destination_image_extension}"
	fi

	# Eseguo la compressione in un'immagine con la seguente legenda: immagine_sorgente.png -> immagine_sorgente_compressed.<estensione desiderata>
	sips -s format $destination_image_extension -s formatOptions low $source_image_absolute_path --out "${path_to_source_image_folder}/${new_folder_name}/${destination_image_extension}/${source_image_filename}_compressed.${destination_image_extension}"
}

if [ $# -gt 0 ]; then
	if [[ -f "$1" ]]; then

		echo "Hai passato un file"
		compress_and_save $1 $2

	elif [[ -d "$1" ]]; then

		echo "Hai passato una cartella"
		for _file in $1*; do

			if [[ -f "$_file" ]]; then
				compress_and_save $_file $2

			else
				echo "Skippando ${_file} in quanto non si tratta di file"

			fi

		done

	else
		echo "Ma che stai passando...?"

	fi

else
	echo "Non è stato definito alcun parametro, specificare:\nImmagine da comprimere (mandatory)\nEstensione da sostituire (optional)"
	
fi