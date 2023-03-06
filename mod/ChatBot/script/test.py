import os
import openai

openai.api_key = "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"

start_sequence = "\nA:"
restart_sequence = "\n\nQ: "

while 1==1:
    prompt = input(restart_sequence)
    if prompt == 'quit':
        break
    else:
        response = openai.Completion.create(
            model="text-davinci-003",
            prompt=prompt,
            temperature=0,
            max_tokens=1024,
            top_p=1,
            frequency_penalty=0,
            presence_penalty=0
            #   stop=["\n"]
        )
        print(start_sequence, response["choices"][0]["text"].strip())