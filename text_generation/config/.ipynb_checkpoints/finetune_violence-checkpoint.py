import time

out_dir = 'out-violence'
eval_interval = 200
wandb_log = True # feel free to turn on
wandb_project = 'violence'
wandb_run_name = 'ft-' + str(time.time())
compile = False # takes too little time to finetune, not worth it

# save a violent checkpoint
always_save_checkpoint = True

dataset = 'violence'
init_from = 'resume'
batch_size = 1
block_size = 512

learning_rate = 1e-5
max_iters = 10000
decay_lr = False
