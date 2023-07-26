## Wednesday 26th July | 9:30 - 17:00 | Online

<center><img src="https://hackmd.io/_uploads/BJhCpazt2.png" alt="baskerville-logo" width="200"/></center>

The Baskerville team are holding a 1-day remote drop-in session for all users of the HPC cluster! This is your opportunity to ask our RSEs questions about how to use Baskerville.

## :calendar: Schedule

| Time          | Topic                                                                            | Led By | Helper | HackMD |
| ------------- | -------------------------------------------------------------------------------- | ------ | ------ | ------ |
| 09:30 - 10:30 | Logging in and Module Loading (1h)                                           | Dimitrios       |  Gavin      | James        |
| 10:30 - 10:45 | Break (15m)                                                                           |        |        |        |
| 10:45 - 12:15 | Non-Interactive Batch Jobs (`sbatch`) and Interactive Jobs (`srun`)  (1h30) | James & Gavin | Simon       | Jenny       |
| 12:15 - 13:15 | Lunch (1h)                                                                           |        |        |        |
| 13:15 - 14:30 | Self-installed software with `pip` and `conda`  (1h15)                      | Simon & Jenny | James       | Gavin       |
| 14:30 - 14:45 | Break (15m)                                                                           |        |        |        |
| 14:45 - 15:45 | VS Code Remote Development  (1h)                                                 | Jenny  |  Simon      | Simon        |
| 14:45 - 15:45 | RELION Breakout Session (1h)                                                     | Gavin  | Dimitrios       | James       |
| 15:45 - 16:00 | Break (15m)                                                                            |        |        |        |
| 16:00 - 17:00 | Data Transfers with Globus  (1h)                                             | James  | Dimitrios       |  Gavin      |

## :movie_camera: Zoom

[Zoom link](https://bham-ac-uk.zoom.us/j/89254012731?pwd=RWErQTlwSXQ4dDNpNk44d3ZXQ1ZHUT09)

**Meeting ID:** 892 5401 2731

**Passcode:** 304957

This event will not be recorded.

## :link: Useful Resources

- [Baskerville Code of Conduct](https://github.com/baskerville-hpc/code-of-conduct)
- [Baskerville Docs](https://docs.baskerville.ac.uk/)
- [Baskerville GitHub](https://github.com/baskerville-hpc)
- [Baskerville Admin](https://admin.baskerville.ac.uk/)
- [Baskerville Apps](https://apps.baskerville.ac.uk/)
- [Baskerville Portal](https://portal.baskerville.ac.uk/)

## :spiral_note_pad: Use this document!

Useful comments in the Zoom chat disappear after the event, so we will use this HackMD document as a collaborative note taking tool.

This document will be placed in our public [GitHub](https://github.com/baskerville-hpc) repo (with identifying information removed) for your future reference.


## :one: 09:30 - 10:30 | Logging in and Module Loading

Hello, welcome to this session; please ask your questions here!

- [ ] Using gnu screen: I've sometimes found after logging in my screen sessions aren't available, maybe because there are multiple login nodes and I'm on a different node from previously? Is this something that could happen? Is there a way to avoid it?

    - [name=JamesAllsopp] Yes, that is a problem, there are 3 login nodes on Baskerville, 
        - bask-pg0310u16a
        - bask-pg0310u18a
        - bask-pg0310u20a

    If you login to one that you didn't want i.e. bask-pg0310u16a and you wanted to log into bask-pg0310u20a, you can just ssh across with;

    `ssh bask-pg0310u20a`

    or log out and take pot luck. I go with the first option.

    - Note there's no way to choose which login node you get from outside of Baskerville.

    - This is going to be covered by Gavin in the interactive session.

    - [name=llewelld] _Thank you!_ :thumbsup:

    - [name=wongj] To add to the above question, you can also configure `ProxyJump` in your `~/.ssh/config` file. I will cover this in my session on *4 - VS Code Remote Development*

- [name=wongj] Another thing about module loading is that this is preferred in the first instance - these are applications built by specialists like Gavin which are optimized for Baskerville for the best performance 

- [ ] One ssh public key restriction: is there any plan to relax this in the future? E.g. can we add keys to an `~/.ssh/authorized_keys` file?
    - No, only a single SSH key is allowed for use to access Baskerville Admin at any one time, and must also be registered in the [Baskerville Authentication Portal](https://bear-auth.bham.ac.uk/auth/realms/baskerville/account/)


## :two: 10:45 - 12:15 | Non-Interactive Batch Jobs (`sbatch`) and Interactive Jobs (`srun`)

Welcome back everyone! 

- [name=wongj] I use this [tmux cheatsheet](https://tmuxcheatsheet.com/) *a lot!* 
- You can Google what the Slurm exit codes are, but each HPC cluster will have their own custom exit codes too
- We have 46 nodes with Nvidia A100-40 GPUs and 6 nodes with A100-80 GPUs

- [ ] Can you talk a bit about tasks/nodes/tasks per node/threads/etc *I'll ask James to cover this if he hasn't already at the end :smile:*
    - https://docs.baskerville.ac.uk/jobs/#multi-gpu-multi-task-or-multi-node-jobs
- [ ] Where is the working directory of a slurm job set? Is it possible to find out the location of the slurm job script from within the script? *The working directory is the directory where you sbatch your job script from. For your second question, you could use an environment variable like `$(PWD)` from within your job script.*
    - [name=llewelld] Thanks! Just to clarify though, it often makes mores sense to me to work relative to the script location, so I can store all my stuff relative to the launch script. `$(PWD)` won't give me that I don't think? I'd prefer not to use absolute paths. 
    - *You can extend `$(PWD)` to paths relative to that, e.g. `$(PWD)/my_folder`. Is this what you mean?*
    - [name=llewelld] Yes, like that, but instead doing `$(SLURM_SCRIPT_FOLDER)/my_folder`, if that makes sense :smiley:
    - Okay, so `$(SLURM_SCRIPT_FOLDER)` is equivalent to `$(PWD)` is equivalent to the directory you sbatch your job from?
    - [name=llewelld] Yes, except it's the directory the script is in, rather than where it was started from. E.g. If I were to run `sbatch ./location/of/my/script` then `$PWD` would be `.` (I think??) whereas `${SLURM_SCRIPT_FOLDER}` would be `./location/of/my/`. - But let me pick this up elsewhere; sorry for the confusing question on my part!
    - Ah got it! Then for the slurm output files, then the comment below about `#SBATCH --output` would work, and then for your other file outputs from your job, you could add `mv .myfile.out ./location/of/my/` at the end of your job script?
    - [name=llewelld] Will check it; thank you!
    - The [`-D --chdir` option](https://slurm.schedmd.com/sbatch.html) to set the working directory before you launch the job may also be helpful to you! 
    - [name=llewelld] It's been pointed out to me (thank you Rosie) that `$0` may be what I need.
    - :thumbsup: 

- [name=dimitriosbellos] If I understood correctly, in the submission script you cannot use bash variables to set where to print the output, correct?
    - That's correct, just for the location of the output files using the `#SBATCH --output` flag, otherwise in the body of your job script, you can access environment variables such as `$PWD` as normal
    - 👍
    - To overcome this I use a python script that creates multiple job.sh scripts with the `#SBATCH --output = <specific-path>` printed in them. And then I have a `master.sh` script that in has many lines with `sbatch job1.sh; sbatch job2.sh` and so on and to execute it and in essence sbatch all the job submission scripts I run:
    - `bash master.sh`
    - The python script I either run it locally to make all the `job.sh` scripts or on Baskerville using `srun` to run as short-lived interactive job
    
- [name=dimitriosbellos] Will in the future maybe the .stats file include info about the GPU Utilization and VRAM allocation? This way people can accurately estimate how many GPUs they need, and or how much room they have to utilise the ones they request.
    - I've asked our infrastructure team if this is recorded anywhere on Slurm, otherwise, I think you will manually have to profile this yourself using an application such as [NSight systems](https://apps.baskerville.ac.uk/applications/Nsight-Systems/) and [ARM Forge](https://apps.baskerville.ac.uk/applications/Arm-Forge/)
    - If at some point (it is not high priority) we could make a page in the documentation on how to use them to monitor the GPUs it would be great. This is something that affects everybody (almost all users use GPUs) but not so many know how to use the Nvidia's NSight Systems
    - I agree! Would definitely be useful to develop more training around this topic too - maybe at a future drop-in!
    - 👍 Great. I mention this because [name=MarkBasham] mentioned to me the other day, that even though most GPUs are not available, the GPU utilisation does not reach close to lets say 90% - 95% probably because many submit multiple jobs that partially utilise the GPUs
    - Yeah we are aware of this problem, so watch this space for multi-instance GPU (MIG) which we are currently looking into to address this
    - I will 👍

- [name=dimitriosbellos] For the X11 forwarding use `-X` option when sshing to Baskerville and `--x11` option in `srun` and then if you start graphical apps in the srun then the GUIs will be forwarded to the local machine



## :three: 13:15 - 14:30 | Self-installed software with `pip` and `conda`


- [name=Gavin] Feel free to ask any and all questions
- [pip-chill](https://pip-chill.readthedocs.io/) documentation
- [name=dimitriosbellos] I have a question regarding conda virtual environments. Can you create them? And should all dependencies be covered by the conda packages installed in the conda virtual environment and not from modules?
    - [name=Gavin] answered my question and yes with conda virtual environments all dependencies should be covered by conda packages installed in the virtual environment. However base virtual environments could be used and shared in order to create a foundation for conda virtual environment creation.

- [name=Will] If multiple users are likely to use the same packages, is it best practice to ask for a new module to be created which provides access to those libraries?
    - Yes - please drop us an email for application installs! Gavin is our resident Research Applications Specialist for Baskerville - let him worry about this and not you :wink: 
- [name=llewelld] With pip you can't install different python versions (I think this is correct?) so then the best way for specific python versions is to ask for a module?
    - [name=Gavin] We typically tend to pin Python versions to the toolchains we have installed. If you require a specific version of python it might be best to use Conda.

- [name=dimitriosbellos] For conda packages that need CUDA since the CUDA module cannot be utilised should CUDA be installed in the conda virtual environment as a conda package (https://anaconda.org/nvidia/cuda) ?
    - [name=Gavin] We encourage a complete separation of modules from your conda environment. Since we have only A100 GPUs you have to make sure it is CUDA 11 or newer.
    - [name=dimitriosbellos] Because you recommend to create conda virtual environments using Jupyter Notebook (it is a Baskerville Portal Interactive App) and because there should be complete separation then yes, CUDA should be installed as a conda package in the virtual environment (this in case conda packages installed in the virtual environment fails to include CUDA as a dependancy that be installed via conda). And of course it should be CUDA 11 or newer.
- [name=llewelld] I notice I have some conda stuff in my .bashrc (``# >>> conda initialize >>>`` etc... ). I probably added that myself, would have been advised to by conda. Was that a mistake? (It says `!! Contents within this block are managed by 'conda init' !!`)
    - [name=Gavin] I would remove that from your `.bashrc`


## :four: 14:45 - 15:45 | VS Code Remote Development

- [name=SimonH] [VS Code Remote Explorer](https://marketplace.visualstudio.com/items?itemName=ms-vscode.remote-explorer) 
- [name=SimonH] [VS Code Remote Development tools](https://code.visualstudio.com/docs/remote/ssh) 
- [name=SimonH] [baskerville tensorboard apps](https://apps.baskerville.ac.uk/search?search=tensorboard)
- [name=SimonH] [VSCode advanced terminal use](https://code.visualstudio.com/docs/terminal/advanced)
- [name=SimonH] [tmux-vs-screen-choosing-the-right-multiplexer](https://www.fosslinux.com/104048/tmux-vs-screen-choosing-the-right-multiplexer.htm)

## :four: 14:45 - 15:45 | RELION Breakout Session


- [name=dimitriosbellos] Tutorials to learn about relion options https://relion.readthedocs.io/en/release-4.0/SPA_tutorial/index.html and https://relion.readthedocs.io/en/release-4.0/STA_tutorial/index.html
    - `Thanks!`
- [name=dimitriosbellos] to create symlink inside the movies directory you can `cd path-to-movies` and then `ln -s <external-directory-you-want-to-link> .`
    - To use regex you can for example do `path-to-data/folders*/data*.err` and then run the import process

- [name=dimitriosbellos] here is more about sbatch options that control the amount of memory allocated https://slurm.schedmd.com/sbatch.html#OPT_mem
- [name=AudreyLaBas] Could we maybe ~~add https://www.cgl.ucsf.edu/chimera/ or https://www.cgl.ucsf.edu/chimerax/?~~
    - [name=dimitriosbellos] The best solution for your needs would be Globus Timers


- [name=ElaineHo] Is there a mechanism to script RELION jobs without generating the commands from the GUI? i.e. running entirely from the terminal.

    - sbatch?
    - https://slurm.schedmd.com/sbatch.html#OPT_dependency

- [name=ElaineHo] Some steps in RELION are CPU-only, should we be doing the CPU-only steps in separate steps from the GPU intensive steps?
    - [name=dimitriosbellos] If this allows you do use more GPUs yes, as this will accelarate your workload more.

- [name=ElaineHo] Where should the project files be stored? `/tmp`, `/scratch/global` ...? Some of the RELION steps do have quite intensive IO processes
    - [name=dimitriosbellos] Use the project storage

## :five: 16:00 - 17:00 | Data Transfers with Globus

- [ ] Write your question here! :pencil: 


## :hugging_face: Conclusion and Feedback

Thank you for participating in the Baskerville Remote Drop-In session! Please bookmark our [GitHub](https://github.com/baskerville-hpc) repo to drop-in materials after this event. 

### Feedback

<center>
    <img src=https://hackmd.io/_uploads/SJFaOoM9n.png width="300">
</center>
<br>

Feedback is important to us and allows us to improve for next time - we would appreciate if you could fill out our feedback form [here](https://forms.office.com/e/gfzmyFjtB2).

- ^ the form is not accepting responses btw...
- Super sorry about that! Should be working now.

### Case Studies

We are always on the lookout for case studies to show off the amazing research that you do on Baskerville HPC :mag: If you are interested in us creating a case study of your work, please [email us](mailto:baskerville-tier2-support@contacts.bham.ac.uk).

### Advice Sessions

If you are interested in booking a 1 hour free advice session with our RSEs, please [email us](mailto:baskerville-tier2-support@contacts.bham.ac.uk) and we will happily book you in. 

### Join the Slack

We have a (hidden) `#baskerville-rse channel` in the [ukrse.slack.com](https://ukrse.slack.com/) Slack - join us there to continue the conversation :smiley:
