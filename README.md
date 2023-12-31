# OpenAI API Scripts

This repository contains scripts that interact with API services provided by OpenAI.

Current Scripts:

- `chatbot_query.pl` - A Perl script to make chatbot API calls to OpenAI
- `chatbot_query.py` - A Python script to make chatbot API calls to OpenAI
- `openai_image_generator.pl` - A Perl script to generate a picture of a sea otter using API calls to OpenAI

## Getting Started

To use these scripts, you'll need to:

1. Clone this repository
2. Install the necessary dependencies
3. Set your OpenAI API key as an environment variable

Then, you can run a script like so:

`perl chatbot_query.pl` or `python chatbot_query.py` or `perl openai_image_generator.pl`

## Script Image Output

The image generator script (openai_image_generator.pl) asks ChatGPT to create a sea otter image.

![Sea Otter](./sea_otter.png)

## Logical Flow

Images created using the api are stored on microsoft cloud and downloaded to the local machine.

![API Flow Diagram](./api_flow.gif)
