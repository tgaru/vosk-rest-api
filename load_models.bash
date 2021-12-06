#!/bin/bash

#----------SUPPORTED LANGUAGES----------
declare -A languages=(
  ["en"]="vosk-model-small-en-us-0.15"
  ["cn"]="vosk-model-small-cn-0.3"
  ["ru"]="vosk-model-small-ru-0.22"
  ["fr"]="vosk-model-small-fr-pguyot-0.3"
  ["de"]="vosk-model-small-de-0.15"
  ["es"]="vosk-model-small-es-0.3"
  ["pt"]="vosk-model-small-pt-0.3"
  ["tr"]="vosk-model-small-tr-0.3"
  ["vn"]="vosk-model-small-vn-0.3"
  ["it"]="vosk-model-small-it-0.4"
  ["ca"]="vosk-model-small-ca-0.4"
  ["fa"]="vosk-model-small-fa-0.5"
  ["uk"]="vosk-model-small-uk-v3-nano"
  ["kz"]="vosk-model-small-kz-0.15"
  ["sv"]="vosk-model-small-sv-rhasspy-0.15"
)
#---------------------------------------

apt install curl unzip

loadLangModel() {
  echo "------------LOADING[$model_lang]------------"
  model_lang=$1
  model_name=$2
  model_dir="models/${model_lang}/"
  if [ ! -d "$model_dir" ]; then
    curl "https://alphacephei.com/vosk/models/${model_name}.zip" --output models/model.zip
    unzip -q models/model.zip -d models/
    mv models/${model_name} ${model_dir}
    rm -rf models/model.zip models/${model_lang}/extra models/${model_lang}/rnnlm
  fi
}

for model_lang in "${!languages[@]}";
do
  model_name=${languages[$model_lang]}
  loadLangModel $model_lang $model_name
done
