source ./scripts/.env

mkdir -p "${CHARTS_DESTINATION}"

ls "$SERVICES_FOLDER" | while read -r service; do
  echo "Copying $service chart to $CHARTS_DESTINATION folder"
  cp -r "$SERVICES_FOLDER/$service/deploy/helm" "$CHARTS_DESTINATION/$service"
done