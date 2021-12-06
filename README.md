VOSK REST API
===================

Simple API over VOSK voice recognition engine with support for multiple languages.

## Supported languages
- en (English)
- cn (Chinese)
- ru (Russian)
- fr (French)
- de (German)
- es (Spanish)
- pt (Portuguese)
- tr (Turkish)
- vn (Vietnamese)
- it (Italian)
- ca (Catalan)
- fa (Farsi)
- uk (Ukrainian)
- kz (Kazakh)
- sv (Swedish)

List of models compatible with Vosk-API: https://alphacephei.com/vosk/models

## Endpoints
```
POST /api/v1/stt - Just look at curl command below.
Speech data may be provided in whatever audio format which ffmpeg is able to convert to wav,
so you probably don't have to worry about this at all.

$ curl -X POST -F "speech=@speech.mp3" -F "lang=en" http://127.0.0.1:15632/api/v1/stt 

{
    "status": "success",
    "result": {
        "text": "experience proves this",
        "time":0.9638644850056153
    }
}
```

## Setup

### 0. Checkout repository
`git clone <repository_url>`

### 1. Download data models
1. Enter `<repository_root>`
2. Run `/bin/bash load_models.bash`

### 2 Running
1. Enter `<repository_root>`
2. Run `docker-compose up`
