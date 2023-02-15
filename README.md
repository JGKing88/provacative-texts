# provocative-texts

Often after a person commits a violent act, from assassinations to shootings, they will cite a novel as the impetus of their evil. It inspired them, or revealed to them the truth, or even told them to. This is a tragic yet compelling phenemon. How could a piece of art - ink on paper - motivate violence? Furthermore, while some texts that have been cited as inciting violence make more sense - American Psycho, others are less clear - Catcher in the Rye. Is there some common thread that makes these texts provocative? It's tough question to explore, so I thought taking text analysis to it may reveal some ideas.

First, I did some general analysis of Catcher in the Rye, famous for inspiring the tragic assassination of John Lennon. I then compared a corpus of similarily provacative texts (listed below) to an average corpus of fiction to find any statistically significant differences. I did find a few, but not outside of what you would expect. Finally, I loaded a pre-trained GPT model and finetuned it with this violence corpus to write a provocative text, hoping it may elucidate what the common theme of provocativity may be. 

I finetuned the GPT-2 XL model from Hugging Face with a NVIDIA A100 Tensor Core GPU (with Lambda Labs). I increased dropout and added weight decay because the model was overfitting far before reaching a loss close to the loss of the GPT-2 XL model. It took many more iterations to reach an optimum than I expected, probably because the finetuning data set is actually relatively large. I generated a few "responses" to prompted questions (questions.txt) after doing a bit of few-shot learning to train question answering. There are certainly darker themes in the responses but more humanities type research needs to be done to examine how it may be provocative.

Instructions:

in text_generation

Prepare the data.
```
cd data/violence
python prepare.py
```
Fine tune
```
python train.py config/finetune_violence.py
```

Next Steps:

* Find a better training method that captures the tone of these texts without taking specific story elements (this was happening a bit). I could validate against a different dataset (fiction in general?) to test this.

Texts:

A Clockwork Orange - Anthony Burgess,
American Psycho - Bret Easton Ellis,
The Catcher in the Rye - J.D. Salinger,
The Collector - John Fowles,
Rage - Richard Bachman,
The Stand - Stephen King,
The Foundation Trilogy - Isaac Asimov
