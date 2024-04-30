source ./scripts/.env


source "./scripts/clean-charts.sh"


if [ -z "${HELM_REGISTRY_ALIAS_ENV_VAR}" ]; then
  echo "HELM_REGISTRY_ALIAS_ENV_VAR is unset or set to the empty string"
else
  HELM_REGISTRY_ALIAS="${HELM_REGISTRY_ALIAS_ENV_VAR}"
fi

CHART_VERSIONS="${CHART_VERSIONS:-"./modules/helm/chart_versions.tf"}"
DESTINATION="${DESTINATION:-"./modules/helm/charts"}"

mkdir -p "${DESTINATION}"

start_timestamp=$(date +%s)

helm repo up

cat "${CHART_VERSIONS}" \
    | egrep '^[a-z0-9\ \-]+= +"' \
    | sed -re 's/^ *([^ ]+) *= *"([^"]+)".*/\1 \2/' > "./scripts/fetched-charts.txt"

while IFS=' ' read -r chart version
do
  echo "fetching chart ${HELM_REGISTRY_ALIAS}$chart:$version"
  helm fetch "${HELM_REGISTRY_ALIAS}$chart" --version "$version" --untar --untardir "${DESTINATION}" || exit 255
done < "./scripts/fetched-charts.txt"

finish_timestamp=$(date +%s)

diff_seconds=$((finish_timestamp - start_timestamp))
echo "total fetch time: $diff_seconds seconds"

echo "\n\nDownloaded charts:\n$(ls -1 "${DESTINATION}"/* )"






