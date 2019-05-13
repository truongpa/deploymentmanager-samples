#! /bin/bash
apt-get update
apt-get install -y apache2

HTML_START="<html><body><h1>VM Metadata From Startup Script</h1><pre>"
HTML_END="</pre></body></html>"

VM_METADATA=$(curl "http://metadata.google.internal/computeMetadata/v1/instance/?recursive=true&alt=text" -H "Metadata-Flavor: Google")

# Encode HTML characters
VM_METADATA=$(echo "$VM_METADATA"|sed 's/&/\&amp;/g; s/</\&lt;/g; s/>/\&gt;/g; s/"/\&quot;/g; s/'"'"'/\&#39;/g')

FILE_CONTENTS="$HTML_START$VM_METADATA$HTML_END"

echo "$FILE_CONTENTS" > /var/www/html/index.html
