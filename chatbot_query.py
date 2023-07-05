#-------------------------------------------------------------
# Script Name:  chatbot_query.py
# Author: TonyB
# Date: July 5 2023
# Purpose: Calls the OpenAI 'Completion' API from Python to 
#          experiment with integration between Python
#          and OpenAI API's.
#
# OpenAI Completion Endpoint Documentation:
#   https://platform.openai.com/docs/api-reference/completions
#
# Before running this script under Windows Powershell, set 
# the api key into the environment with: 
#   $env:OPENAI_API_KEY="sk-ais__MY_KEY__9sPExnwg8piZeCX" 
#
# Changes:
# 7/5/2023 First time deployment. We ask chatGpt how to 
#    bake a cherry pie
#-------------------------------------------------------------
import os
import requests
import json

# get the API key from environment variables
api_key = os.getenv('OPENAI_API_KEY')

headers = {
    'Content-Type': 'application/json',
    'Authorization': f'Bearer {api_key}'
}

data = {
    'model': 'gpt-3.5-turbo',
    'messages': [
        {
            'role': 'system',
            'content': 'You are a helpful assistant.'
        },
        {
            'role': 'user',
            'content': 'Good evening. can you tell me how to bake a cherry pie?'
        }
    ]
}

response = requests.post('https://api.openai.com/v1/chat/completions', headers=headers, data=json.dumps(data))

if response.status_code == 200:
    response_data = response.json()
    assistant_message = response_data['choices'][0]['message']['content']
    print("Assistant's reply:", assistant_message)
else:
    print(f"Error: {response.status_code}, {response.text}")
