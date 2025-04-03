#!/bin/sh
if [ $# -gt 0 ]; then
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

	# Se non ho specificato un'estensione, lascio la medesima dell'immagine sorgente per la compressione
	if [ "$destination_image_extension" = "" ]; then
		destination_image_extension=$source_image_extension
	fi

	# Eseguo la compressione in un'immagine con la seguente legenda: immagine_sorgente.png -> immagine_sorgente_compressed.<estensione desiderata>
	sips -s format $destination_image_extension -s formatOptions low $source_image_absolute_path --out "${path_to_source_image_folder}/${source_image_filename}_compressed.${destination_image_extension}"

else
	echo "Non è stato definito alcun parametro, specificare:\nImmagine da comprimere (mandatory)\nEstensione da sostituire (optional)"
fi