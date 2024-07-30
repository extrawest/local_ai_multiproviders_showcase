#  AI provider flutter app
[![Maintenance](https://img.shields.io/badge/Maintained%3F-yes-green.svg)]()
[![Maintaner](https://img.shields.io/static/v1?label=Oleksandr%20Samoilenko&message=Maintainer&color=red)](mailto:oleksandr.samoilenko@extrawest.com)
[![Ask Me Anything !](https://img.shields.io/badge/Ask%20me-anything-1abc9c.svg)]()
![GitHub license](https://img.shields.io/github/license/Naereen/StrapDown.js.svg)
![GitHub release](https://img.shields.io/badge/release-v1.0.0-blue)

## PROJECT INFO
- **AI provider Application on the latest version of Flutter**
- **We were intended to create a an MVP showcase application that allows you to use Groq, OpenAi and llm.cpp providers through single ui. You only need to select one of the providers and start chatting.**

## Features
- Groq with "mixtral-8x7b-32768"
- OpenAi with "gpt-3.5-turbo"
- Llama.cpp with any model you want

## Installing:
**1. Clone this repo to your folder:**

```
git clone https://github.com/extrawest/local_ai_multiproviders_showcase.git
```

**2. Change current directory to the cloned folder:**

```
cd local_ai_multiproviders_showcase
```

**3. Get packages**

```
flutter pub get
```
## Create .env file
To use Grouq and Openai API you need to add  some information to .env file
```
GROQ_API_KEY='YOUR_GROQ_API_KEY'
GROQ_URL = 'https://api.groq.com/openai' -leave it as is
OPENAI_API_KEY='YOUR_OPENAI_API_KEY'
OPENAI_URL = 'https://api.openai.com' -leave it as is
LLAMACPP_URL = 'URL_TO_YOUR_LLAMACPP_SERVER'
```

## run LLM.CPP server
**1. download this repo**
https://github.com/ggerganov/llama.cpp
**2. Open the project and run the server**
```
./llama-server -m path_to_your_model f -c 2048 --port 8080 --host 127.0.0.1
```
**3. Add the server url to .env file**
You probaly will neet to create a tunnel to your server to make it accessible. You can use ngrok for that.
Run this command
```
ngrok http your_local_url
```

Now you are ready to run the project


## Preview
https://github.com/user-attachments/assets/9977dcb2-b305-44be-87ea-2e31c8ec4a21

https://github.com/user-attachments/assets/5d2f01e9-5e9d-4ce0-acb9-a02aaed50f0d



Created by Oleksandr Samoilenko

[Extrawest.com](https://www.extrawest.com), 2024

