# ActionsDummy

A Proof of concept of cross-repository GitHub Actions Triggers

This repository, along with [ActionsReceiverDummy] serve as working examples to
"how do you trigger GitHub Actions to build from another repo?"

## Requirements

- GitHub Personal Access Toke (PAT) with `public_repo` access to perform authenticated
curls to GitHub API's with [repository_dispatch] events
- Second repository with GitHub Action setup to react to [repository_dispatch] events
- Patience

## How it works

1. A traditional ["on push" GitHub Action](.github/workflows/build-and-report.yaml) does some normal build steps
    - This one specifically builds a Docker image
    - Authenticates with GitHub Container Registry
    - Pushes the images
2. After publishing your desired artifact, performs an authenticated manual event
    - Uses Action Secret for the PAT previously mentioned
    - Simple curl command for `https://api.github.com/repos/<owner>/<repository>/dispatches`
3. [Receiver Repository Action](https://github.com/gabizou/ActionsReceiverDummy/blob/f0afbe9a4cf081dc439d59de311060a984d88587/.github/workflows/receiver.yaml) does stuff with the payload

## Example Output

<details>
<summary>Producer Output</summary>

```
2021-09-30T19:36:07.2077824Z Found online and idle hosted runner in the current repository's organization account that matches the required labels: 'ubuntu-20.04'
2021-09-30T19:36:07.3018182Z Waiting for a Hosted runner in the 'organization' to pick this job...
2021-09-30T19:36:07.6590255Z Job is waiting for a hosted runner to come online.
2021-09-30T19:36:10.3333897Z Job is about to start running on the hosted runner: Hosted Agent (hosted)
2021-09-30T19:36:14.2370077Z Current runner version: '2.283.1'
2021-09-30T19:36:14.2405729Z ##[group]Operating System
2021-09-30T19:36:14.2406776Z Ubuntu
2021-09-30T19:36:14.2407279Z 20.04.3
2021-09-30T19:36:14.2407778Z LTS
2021-09-30T19:36:14.2408777Z ##[endgroup]
2021-09-30T19:36:14.2409366Z ##[group]Virtual Environment
2021-09-30T19:36:14.2410104Z Environment: ubuntu-20.04
2021-09-30T19:36:14.2410715Z Version: 20210929.1
2021-09-30T19:36:14.2411822Z Included Software: https://github.com/actions/virtual-environments/blob/ubuntu20/20210929.1/images/linux/Ubuntu2004-README.md
2021-09-30T19:36:14.2413294Z Image Release: https://github.com/actions/virtual-environments/releases/tag/ubuntu20%2F20210929.1
2021-09-30T19:36:14.2414277Z ##[endgroup]
2021-09-30T19:36:14.2414919Z ##[group]Virtual Environment Provisioner
2021-09-30T19:36:14.2415670Z 1.0.0.0-master-20210914-1
2021-09-30T19:36:14.2416226Z ##[endgroup]
2021-09-30T19:36:14.2417709Z ##[group]GITHUB_TOKEN Permissions
2021-09-30T19:36:14.2419101Z Contents: read
2021-09-30T19:36:14.2419807Z Metadata: read
2021-09-30T19:36:14.2420347Z Packages: write
2021-09-30T19:36:14.2421037Z ##[endgroup]
2021-09-30T19:36:14.2424268Z Prepare workflow directory
2021-09-30T19:36:14.3141242Z Prepare all required actions
2021-09-30T19:36:14.3151294Z Getting action download info
2021-09-30T19:36:14.7005595Z Download action repository 'actions/checkout@v2' (SHA:5a4ac9002d0be2fb38bd78e4b4dbde5606d7042f)
2021-09-30T19:36:16.4048879Z Download action repository 'docker/login-action@v1' (SHA:f054a8b539a109f9f41c372932f1ae047eff08c9)
2021-09-30T19:36:17.0151614Z ##[group]Run actions/checkout@v2
2021-09-30T19:36:17.0152225Z with:
2021-09-30T19:36:17.0152672Z   repository: gabizou/ActionsDummy
2021-09-30T19:36:17.0153614Z   token: ***
2021-09-30T19:36:17.0153995Z   ssh-strict: true
2021-09-30T19:36:17.0154486Z   persist-credentials: true
2021-09-30T19:36:17.0154936Z   clean: true
2021-09-30T19:36:17.0155319Z   fetch-depth: 1
2021-09-30T19:36:17.0155693Z   lfs: false
2021-09-30T19:36:17.0156070Z   submodules: false
2021-09-30T19:36:17.0156450Z env:
2021-09-30T19:36:17.0156802Z   REGISTRY: ghcr.io
2021-09-30T19:36:17.0157304Z   IMAGE_NAME: gabizou/golang-ci-actions
2021-09-30T19:36:17.0157785Z ##[endgroup]
2021-09-30T19:36:17.7312617Z Syncing repository: gabizou/ActionsDummy
2021-09-30T19:36:17.7336444Z ##[group]Getting Git version info
2021-09-30T19:36:17.7338015Z Working directory is '/home/runner/work/ActionsDummy/ActionsDummy'
2021-09-30T19:36:17.7339419Z [command]/usr/bin/git version
2021-09-30T19:36:17.7339952Z git version 2.33.0
2021-09-30T19:36:17.7342068Z ##[endgroup]
2021-09-30T19:36:17.7342984Z Deleting the contents of '/home/runner/work/ActionsDummy/ActionsDummy'
2021-09-30T19:36:17.7345417Z ##[group]Initializing the repository
2021-09-30T19:36:17.7346612Z [command]/usr/bin/git init /home/runner/work/ActionsDummy/ActionsDummy
2021-09-30T19:36:17.7347764Z hint: Using 'master' as the name for the initial branch. This default branch name
2021-09-30T19:36:17.7348658Z hint: is subject to change. To configure the initial branch name to use in all
2021-09-30T19:36:17.7349563Z hint: of your new repositories, which will suppress this warning, call:
2021-09-30T19:36:17.7350202Z hint: 
2021-09-30T19:36:17.7350985Z hint: 	git config --global init.defaultBranch <name>
2021-09-30T19:36:17.7351606Z hint: 
2021-09-30T19:36:17.7352371Z hint: Names commonly chosen instead of 'master' are 'main', 'trunk' and
2021-09-30T19:36:17.7353434Z hint: 'development'. The just-created branch can be renamed via this command:
2021-09-30T19:36:17.7354115Z hint: 
2021-09-30T19:36:17.7354742Z hint: 	git branch -m <name>
2021-09-30T19:36:17.7355538Z Initialized empty Git repository in /home/runner/work/ActionsDummy/ActionsDummy/.git/
2021-09-30T19:36:17.7356733Z [command]/usr/bin/git remote add origin https://github.com/gabizou/ActionsDummy
2021-09-30T19:36:17.7358345Z ##[endgroup]
2021-09-30T19:36:17.7359566Z ##[group]Disabling automatic garbage collection
2021-09-30T19:36:17.7360489Z [command]/usr/bin/git config --local gc.auto 0
2021-09-30T19:36:17.7361833Z ##[endgroup]
2021-09-30T19:36:17.7364542Z ##[group]Setting up auth
2021-09-30T19:36:17.7365495Z [command]/usr/bin/git config --local --name-only --get-regexp core\.sshCommand
2021-09-30T19:36:17.7367032Z [command]/usr/bin/git submodule foreach --recursive git config --local --name-only --get-regexp 'core\.sshCommand' && git config --local --unset-all 'core.sshCommand' || :
2021-09-30T19:36:17.7369116Z [command]/usr/bin/git config --local --name-only --get-regexp http\.https\:\/\/github\.com\/\.extraheader
2021-09-30T19:36:17.7371407Z [command]/usr/bin/git submodule foreach --recursive git config --local --name-only --get-regexp 'http\.https\:\/\/github\.com\/\.extraheader' && git config --local --unset-all 'http.https://github.com/.extraheader' || :
2021-09-30T19:36:17.7373265Z [command]/usr/bin/git config --local http.https://github.com/.extraheader AUTHORIZATION: basic ***
2021-09-30T19:36:17.7374758Z ##[endgroup]
2021-09-30T19:36:17.7375687Z ##[group]Fetching the repository
2021-09-30T19:36:17.7377508Z [command]/usr/bin/git -c protocol.version=2 fetch --no-tags --prune --progress --no-recurse-submodules --depth=1 origin +731ab2883864881398d822e5fcba0f2e66fe4be0:refs/remotes/origin/main
2021-09-30T19:36:17.7378673Z remote: Enumerating objects: 9, done.        
2021-09-30T19:36:17.7379215Z remote: Counting objects:  11% (1/9)        
2021-09-30T19:36:17.7379711Z remote: Counting objects:  22% (2/9)        
2021-09-30T19:36:17.7380193Z remote: Counting objects:  33% (3/9)        
2021-09-30T19:36:17.7380879Z remote: Counting objects:  44% (4/9)        
2021-09-30T19:36:17.7381375Z remote: Counting objects:  55% (5/9)        
2021-09-30T19:36:17.7381872Z remote: Counting objects:  66% (6/9)        
2021-09-30T19:36:17.7382375Z remote: Counting objects:  77% (7/9)        
2021-09-30T19:36:17.7382856Z remote: Counting objects:  88% (8/9)        
2021-09-30T19:36:17.7385474Z remote: Counting objects: 100% (9/9)        
2021-09-30T19:36:17.7386155Z remote: Counting objects: 100% (9/9), done.        
2021-09-30T19:36:17.7386852Z remote: Compressing objects:  16% (1/6)        
2021-09-30T19:36:17.7387494Z remote: Compressing objects:  33% (2/6)        
2021-09-30T19:36:17.7388145Z remote: Compressing objects:  50% (3/6)        
2021-09-30T19:36:17.7388788Z remote: Compressing objects:  66% (4/6)        
2021-09-30T19:36:17.7389409Z remote: Compressing objects:  83% (5/6)        
2021-09-30T19:36:17.7390042Z remote: Compressing objects: 100% (6/6)        
2021-09-30T19:36:17.7390717Z remote: Compressing objects: 100% (6/6), done.        
2021-09-30T19:36:17.7391811Z remote: Total 9 (delta 0), reused 5 (delta 0), pack-reused 0        
2021-09-30T19:36:17.7392640Z From https://github.com/gabizou/ActionsDummy
2021-09-30T19:36:17.7393689Z  * [new ref]         731ab2883864881398d822e5fcba0f2e66fe4be0 -> origin/main
2021-09-30T19:36:17.7394907Z ##[endgroup]
2021-09-30T19:36:17.7395970Z ##[group]Determining the checkout info
2021-09-30T19:36:17.7397006Z ##[endgroup]
2021-09-30T19:36:17.7398000Z ##[group]Checking out the ref
2021-09-30T19:36:17.7399009Z [command]/usr/bin/git checkout --progress --force -B main refs/remotes/origin/main
2021-09-30T19:36:17.7399907Z Switched to a new branch 'main'
2021-09-30T19:36:17.7400746Z Branch 'main' set up to track remote branch 'main' from 'origin'.
2021-09-30T19:36:17.7401847Z ##[endgroup]
2021-09-30T19:36:17.7402535Z [command]/usr/bin/git log -1 --format='%H'
2021-09-30T19:36:17.7403374Z '731ab2883864881398d822e5fcba0f2e66fe4be0'
2021-09-30T19:36:17.7492042Z ##[group]Run docker/login-action@v1
2021-09-30T19:36:17.7492508Z with:
2021-09-30T19:36:17.7492870Z   registry: ghcr.io
2021-09-30T19:36:17.7493272Z   username: gabizou
2021-09-30T19:36:17.7494350Z   password: ***
2021-09-30T19:36:17.7494707Z   logout: true
2021-09-30T19:36:17.7495041Z env:
2021-09-30T19:36:17.7495412Z   REGISTRY: ghcr.io
2021-09-30T19:36:17.7495902Z   IMAGE_NAME: gabizou/golang-ci-actions
2021-09-30T19:36:17.7496382Z ##[endgroup]
2021-09-30T19:36:18.4068329Z Logging into ghcr.io...
2021-09-30T19:36:18.4411748Z Login Succeeded!
2021-09-30T19:36:18.4535360Z ##[group]Run docker build . -t ghcr.io/gabizou/golang-ci-actions:1.15 -t ghcr.io/gabizou/golang-ci-actions:latest -f Dockerfile
2021-09-30T19:36:18.4536690Z [36;1mdocker build . -t ghcr.io/gabizou/golang-ci-actions:1.15 -t ghcr.io/gabizou/golang-ci-actions:latest -f Dockerfile[0m
2021-09-30T19:36:18.4537658Z [36;1mdocker push ghcr.io/gabizou/golang-ci-actions:latest[0m
2021-09-30T19:36:18.4538392Z [36;1mdocker push ghcr.io/gabizou/golang-ci-actions:1.15[0m
2021-09-30T19:36:18.4583724Z shell: /usr/bin/bash -e {0}
2021-09-30T19:36:18.4584112Z env:
2021-09-30T19:36:18.4584490Z   REGISTRY: ghcr.io
2021-09-30T19:36:18.4584984Z   IMAGE_NAME: gabizou/golang-ci-actions
2021-09-30T19:36:18.4585472Z ##[endgroup]
2021-09-30T19:36:18.5101781Z Sending build context to Docker daemon  80.38kB
2021-09-30T19:36:18.5102195Z 
2021-09-30T19:36:18.5489760Z Step 1/3 : FROM golang:1.15-alpine
2021-09-30T19:36:19.3086968Z 1.15-alpine: Pulling from library/golang
2021-09-30T19:36:19.4815784Z 29291e31a76a: Pulling fs layer
2021-09-30T19:36:19.4817217Z e4bc8fc554c3: Pulling fs layer
2021-09-30T19:36:19.4818495Z 803daa35ea47: Pulling fs layer
2021-09-30T19:36:19.4819482Z 38284154e396: Pulling fs layer
2021-09-30T19:36:19.4820373Z a66f7597198a: Pulling fs layer
2021-09-30T19:36:19.4821223Z 38284154e396: Waiting
2021-09-30T19:36:19.4822094Z a66f7597198a: Waiting
2021-09-30T19:36:19.7428268Z e4bc8fc554c3: Verifying Checksum
2021-09-30T19:36:19.7429422Z e4bc8fc554c3: Download complete
2021-09-30T19:36:19.7578928Z 803daa35ea47: Verifying Checksum
2021-09-30T19:36:19.7579512Z 803daa35ea47: Download complete
2021-09-30T19:36:19.8116622Z 29291e31a76a: Verifying Checksum
2021-09-30T19:36:19.8120981Z 29291e31a76a: Download complete
2021-09-30T19:36:19.9333902Z 29291e31a76a: Pull complete
2021-09-30T19:36:20.0171349Z a66f7597198a: Verifying Checksum
2021-09-30T19:36:20.0188857Z a66f7597198a: Download complete
2021-09-30T19:36:20.5002714Z e4bc8fc554c3: Pull complete
2021-09-30T19:36:20.7117482Z 803daa35ea47: Pull complete
2021-09-30T19:36:21.0123267Z 38284154e396: Verifying Checksum
2021-09-30T19:36:21.0127858Z 38284154e396: Download complete
2021-09-30T19:36:25.9045221Z 38284154e396: Pull complete
2021-09-30T19:36:25.9675048Z a66f7597198a: Pull complete
2021-09-30T19:36:25.9736136Z Digest: sha256:b58c367d52e46cdedc25ec9cd74cadb14ad65e8db75b25e5ec117cdb227aa264
2021-09-30T19:36:25.9755841Z Status: Downloaded newer image for golang:1.15-alpine
2021-09-30T19:36:25.9777517Z  ---> 1403af3b6d4a
2021-09-30T19:36:25.9778062Z Step 2/3 : LABEL maintainer=gabizou
2021-09-30T19:36:26.0021992Z  ---> Running in 9292eaa889eb
2021-09-30T19:36:27.0267215Z Removing intermediate container 9292eaa889eb
2021-09-30T19:36:27.0268627Z  ---> 1acfd8fab20e
2021-09-30T19:36:27.0269434Z Step 3/3 : RUN apk add --no-cache gcc musl-dev git
2021-09-30T19:36:27.0499991Z  ---> Running in a90bc4129495
2021-09-30T19:36:27.3410524Z fetch https://dl-cdn.alpinelinux.org/alpine/v3.14/main/x86_64/APKINDEX.tar.gz
2021-09-30T19:36:27.5139293Z fetch https://dl-cdn.alpinelinux.org/alpine/v3.14/community/x86_64/APKINDEX.tar.gz
2021-09-30T19:36:27.7179727Z (1/18) Installing libgcc (10.3.1_git20210424-r2)
2021-09-30T19:36:27.7629396Z (2/18) Installing libstdc++ (10.3.1_git20210424-r2)
2021-09-30T19:36:27.7634795Z (3/18) Installing binutils (2.35.2-r2)
2021-09-30T19:36:27.8455365Z (4/18) Installing libgomp (10.3.1_git20210424-r2)
2021-09-30T19:36:27.8636339Z (5/18) Installing libatomic (10.3.1_git20210424-r2)
2021-09-30T19:36:27.8789292Z (6/18) Installing libgphobos (10.3.1_git20210424-r2)
2021-09-30T19:36:27.9417111Z (7/18) Installing gmp (6.2.1-r0)
2021-09-30T19:36:27.9627844Z (8/18) Installing isl22 (0.22-r0)
2021-09-30T19:36:27.9962091Z (9/18) Installing mpfr4 (4.1.0-r0)
2021-09-30T19:36:28.0356805Z (10/18) Installing mpc1 (1.2.1-r0)
2021-09-30T19:36:28.0518835Z (11/18) Installing gcc (10.3.1_git20210424-r2)
2021-09-30T19:36:28.7661558Z (12/18) Installing brotli-libs (1.0.9-r5)
2021-09-30T19:36:28.7905418Z (13/18) Installing nghttp2-libs (1.43.0-r0)
2021-09-30T19:36:28.8069742Z (14/18) Installing libcurl (7.79.1-r0)
2021-09-30T19:36:28.8297411Z (15/18) Installing expat (2.4.1-r0)
2021-09-30T19:36:28.8468419Z (16/18) Installing pcre2 (10.36-r0)
2021-09-30T19:36:28.8702345Z (17/18) Installing git (2.32.0-r0)
2021-09-30T19:36:29.0003098Z (18/18) Installing musl-dev (1.2.2-r3)
2021-09-30T19:36:29.0914642Z Executing busybox-1.33.1-r3.trigger
2021-09-30T19:36:29.0960339Z OK: 140 MiB in 33 packages
2021-09-30T19:36:31.8271871Z Removing intermediate container a90bc4129495
2021-09-30T19:36:31.8273622Z  ---> 3d8ecdba5910
2021-09-30T19:36:31.8284068Z Successfully built 3d8ecdba5910
2021-09-30T19:36:31.8316948Z Successfully tagged ghcr.io/gabizou/golang-ci-actions:1.15
2021-09-30T19:36:31.8352045Z Successfully tagged ghcr.io/gabizou/golang-ci-actions:latest
2021-09-30T19:36:31.8764377Z The push refers to repository [ghcr.io/gabizou/golang-ci-actions]
2021-09-30T19:36:31.9987985Z 40fc70a46f5b: Preparing
2021-09-30T19:36:31.9988506Z 1cdba0ea84fc: Preparing
2021-09-30T19:36:31.9988994Z 8ad0a1441de6: Preparing
2021-09-30T19:36:31.9989438Z c0ed5374a14a: Preparing
2021-09-30T19:36:31.9989872Z 6d0c7e68c043: Preparing
2021-09-30T19:36:31.9990286Z bc276c40b172: Preparing
2021-09-30T19:36:31.9990695Z bc276c40b172: Waiting
2021-09-30T19:36:32.3360293Z 6d0c7e68c043: Layer already exists
2021-09-30T19:36:32.3483297Z 8ad0a1441de6: Layer already exists
2021-09-30T19:36:32.3627897Z 1cdba0ea84fc: Layer already exists
2021-09-30T19:36:32.3683435Z c0ed5374a14a: Layer already exists
2021-09-30T19:36:32.5136351Z bc276c40b172: Layer already exists
2021-09-30T19:36:40.5911480Z 40fc70a46f5b: Pushed
2021-09-30T19:36:42.8126832Z latest: digest: sha256:d1b20d86a87def89612a8842839ec5131aba5b75d961a57de808baa910118855 size: 1577
2021-09-30T19:36:42.8522576Z The push refers to repository [ghcr.io/gabizou/golang-ci-actions]
2021-09-30T19:36:42.9595284Z 40fc70a46f5b: Preparing
2021-09-30T19:36:42.9595980Z 1cdba0ea84fc: Preparing
2021-09-30T19:36:42.9596486Z 8ad0a1441de6: Preparing
2021-09-30T19:36:42.9597032Z c0ed5374a14a: Preparing
2021-09-30T19:36:42.9597527Z 6d0c7e68c043: Preparing
2021-09-30T19:36:42.9598018Z bc276c40b172: Preparing
2021-09-30T19:36:42.9598498Z bc276c40b172: Waiting
2021-09-30T19:36:43.2956819Z 8ad0a1441de6: Layer already exists
2021-09-30T19:36:43.3076148Z 1cdba0ea84fc: Layer already exists
2021-09-30T19:36:43.3076764Z 40fc70a46f5b: Layer already exists
2021-09-30T19:36:43.3120163Z 6d0c7e68c043: Layer already exists
2021-09-30T19:36:43.3240414Z c0ed5374a14a: Layer already exists
2021-09-30T19:36:43.4396056Z bc276c40b172: Layer already exists
2021-09-30T19:36:44.4851175Z 1.15: digest: sha256:d1b20d86a87def89612a8842839ec5131aba5b75d961a57de808baa910118855 size: 1577
2021-09-30T19:36:44.4926564Z ##[group]Run docker pull ghcr.io/gabizou/golang-ci-actions:latest
2021-09-30T19:36:44.4927615Z [36;1mdocker pull ghcr.io/gabizou/golang-ci-actions:latest[0m
2021-09-30T19:36:44.4928814Z [36;1mdigest=$(docker inspect --format='{{index .RepoDigests 0}}' ghcr.io/gabizou/golang-ci-actions)[0m
2021-09-30T19:36:44.4929903Z [36;1mimage_sha=$(echo "$digest" | sed -e "s/^ghcr\.io\/gabizou\/golang-ci-actions\@//")[0m
2021-09-30T19:36:44.4930622Z [36;1mecho $image_sha[0m
2021-09-30T19:36:44.4931142Z [36;1mecho "image_sha=$image_sha" >> $GITHUB_ENV[0m
2021-09-30T19:36:44.4977181Z shell: /usr/bin/bash -e {0}
2021-09-30T19:36:44.4977544Z env:
2021-09-30T19:36:44.4977914Z   REGISTRY: ghcr.io
2021-09-30T19:36:44.4978402Z   IMAGE_NAME: gabizou/golang-ci-actions
2021-09-30T19:36:44.4978881Z ##[endgroup]
2021-09-30T19:36:45.2278289Z latest: Pulling from gabizou/golang-ci-actions
2021-09-30T19:36:45.2299942Z Digest: sha256:d1b20d86a87def89612a8842839ec5131aba5b75d961a57de808baa910118855
2021-09-30T19:36:45.2301836Z Status: Image is up to date for ghcr.io/gabizou/golang-ci-actions:latest
2021-09-30T19:36:45.2307007Z ghcr.io/gabizou/golang-ci-actions:latest
2021-09-30T19:36:45.2673416Z sha256:d1b20d86a87def89612a8842839ec5131aba5b75d961a57de808baa910118855
2021-09-30T19:36:45.2719092Z ##[group]Run curl -X POST https://api.github.com/repos/gabizou/actionsreceiverdummy/dispatches \
2021-09-30T19:36:45.2720576Z [36;1mcurl -X POST https://api.github.com/repos/gabizou/actionsreceiverdummy/dispatches \[0m
2021-09-30T19:36:45.2721764Z [36;1m                  -H 'Accept: application/vnd.github.everest-preview+json' \[0m
2021-09-30T19:36:45.2723609Z [36;1m                  -u *** \[0m
2021-09-30T19:36:45.2724918Z [36;1m                 --data '{"event_type": "image_uploaded", "client_payload": { "repository": "'"$GITHUB_REPOSITORY"'", "image_sha": "sha256:d1b20d86a87def89612a8842839ec5131aba5b75d961a57de808baa910118855" } }'[0m
2021-09-30T19:36:45.2768729Z shell: /usr/bin/bash -e {0}
2021-09-30T19:36:45.2769137Z env:
2021-09-30T19:36:45.2769656Z   REGISTRY: ghcr.io
2021-09-30T19:36:45.2770241Z   IMAGE_NAME: gabizou/golang-ci-actions
2021-09-30T19:36:45.2771285Z   image_sha: sha256:d1b20d86a87def89612a8842839ec5131aba5b75d961a57de808baa910118855
2021-09-30T19:36:45.2772225Z ##[endgroup]
2021-09-30T19:36:45.3071605Z Enter host password for user '***':
2021-09-30T19:36:45.3076084Z   % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
2021-09-30T19:36:45.3078724Z                                  Dload  Upload   Total   Spent    Left  Speed
2021-09-30T19:36:45.3079136Z 
2021-09-30T19:36:45.5070346Z   0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0
2021-09-30T19:36:45.5073318Z 100   181    0     0  100   181      0    909 --:--:-- --:--:-- --:--:--   909
2021-09-30T19:36:45.5157106Z Post job cleanup.
2021-09-30T19:36:45.5608829Z [command]/usr/bin/docker logout ghcr.io
2021-09-30T19:36:45.5926172Z Removing login credentials for ghcr.io
2021-09-30T19:36:45.6089649Z Post job cleanup.
2021-09-30T19:36:45.7062672Z [command]/usr/bin/git version
2021-09-30T19:36:45.7104940Z git version 2.33.0
2021-09-30T19:36:45.7138743Z [command]/usr/bin/git config --local --name-only --get-regexp core\.sshCommand
2021-09-30T19:36:45.7171594Z [command]/usr/bin/git submodule foreach --recursive git config --local --name-only --get-regexp 'core\.sshCommand' && git config --local --unset-all 'core.sshCommand' || :
2021-09-30T19:36:45.7407223Z [command]/usr/bin/git config --local --name-only --get-regexp http\.https\:\/\/github\.com\/\.extraheader
2021-09-30T19:36:45.7424659Z http.https://github.com/.extraheader
2021-09-30T19:36:45.7440612Z [command]/usr/bin/git config --local --unset-all http.https://github.com/.extraheader
2021-09-30T19:36:45.7466169Z [command]/usr/bin/git submodule foreach --recursive git config --local --name-only --get-regexp 'http\.https\:\/\/github\.com\/\.extraheader' && git config --local --unset-all 'http.https://github.com/.extraheader' || :
2021-09-30T19:36:45.7744585Z Cleaning up orphan processes
```
</details>
<details>
<summary>Receiver Output</summary>

```
2021-09-30T19:36:47.2160741Z Found online and idle hosted runner in the current repository's organization account that matches the required labels: 'ubuntu-20.04'
2021-09-30T19:36:47.2923341Z Waiting for a Hosted runner in the 'organization' to pick this job...
2021-09-30T19:36:47.7468530Z Job is waiting for a hosted runner to come online.
2021-09-30T19:36:50.0862714Z Job is about to start running on the hosted runner: GitHub Actions 2 (hosted)
2021-09-30T19:36:52.4946611Z Current runner version: '2.283.1'
2021-09-30T19:36:52.4974001Z ##[group]Operating System
2021-09-30T19:36:52.4974919Z Ubuntu
2021-09-30T19:36:52.4975327Z 20.04.3
2021-09-30T19:36:52.4975800Z LTS
2021-09-30T19:36:52.4976226Z ##[endgroup]
2021-09-30T19:36:52.4976867Z ##[group]Virtual Environment
2021-09-30T19:36:52.4977507Z Environment: ubuntu-20.04
2021-09-30T19:36:52.4978016Z Version: 20210929.1
2021-09-30T19:36:52.4979004Z Included Software: https://github.com/actions/virtual-environments/blob/ubuntu20/20210929.1/images/linux/Ubuntu2004-README.md
2021-09-30T19:36:52.4980273Z Image Release: https://github.com/actions/virtual-environments/releases/tag/ubuntu20%2F20210929.1
2021-09-30T19:36:52.4981177Z ##[endgroup]
2021-09-30T19:36:52.4981794Z ##[group]Virtual Environment Provisioner
2021-09-30T19:36:52.4982394Z 1.0.0.0-master-20210914-1
2021-09-30T19:36:52.4982932Z ##[endgroup]
2021-09-30T19:36:52.4984814Z ##[group]GITHUB_TOKEN Permissions
2021-09-30T19:36:52.4986150Z Actions: write
2021-09-30T19:36:52.4986683Z Checks: write
2021-09-30T19:36:52.4987154Z Contents: write
2021-09-30T19:36:52.4987738Z Deployments: write
2021-09-30T19:36:52.4988250Z Discussions: write
2021-09-30T19:36:52.4988781Z Issues: write
2021-09-30T19:36:52.4989302Z Metadata: read
2021-09-30T19:36:52.4989778Z Packages: write
2021-09-30T19:36:52.4990369Z PullRequests: write
2021-09-30T19:36:52.4990962Z RepositoryProjects: write
2021-09-30T19:36:52.4991601Z SecurityEvents: write
2021-09-30T19:36:52.4992113Z Statuses: write
2021-09-30T19:36:52.4992724Z ##[endgroup]
2021-09-30T19:36:52.4995685Z Prepare workflow directory
2021-09-30T19:36:52.5685061Z Prepare all required actions
2021-09-30T19:36:52.5694633Z Getting action download info
2021-09-30T19:36:52.7635024Z Download action repository 'actions/checkout@v2' (SHA:5a4ac9002d0be2fb38bd78e4b4dbde5606d7042f)
2021-09-30T19:36:54.6310113Z Download action repository 'docker/login-action@v1' (SHA:f054a8b539a109f9f41c372932f1ae047eff08c9)
2021-09-30T19:36:54.9454725Z ##[group]Run actions/checkout@v2
2021-09-30T19:36:54.9455352Z with:
2021-09-30T19:36:54.9455920Z   repository: gabizou/ActionsReceiverDummy
2021-09-30T19:36:54.9456898Z   token: ***
2021-09-30T19:36:54.9457323Z   ssh-strict: true
2021-09-30T19:36:54.9457861Z   persist-credentials: true
2021-09-30T19:36:54.9458362Z   clean: true
2021-09-30T19:36:54.9458795Z   fetch-depth: 1
2021-09-30T19:36:54.9459215Z   lfs: false
2021-09-30T19:36:54.9459655Z   submodules: false
2021-09-30T19:36:54.9460064Z env:
2021-09-30T19:36:54.9460503Z   REPOSITORY: ghcr.io
2021-09-30T19:36:54.9461066Z   BASE_IMAGE: gabizou/golang-ci-actions
2021-09-30T19:36:54.9461585Z ##[endgroup]
2021-09-30T19:36:55.5639714Z Syncing repository: gabizou/ActionsReceiverDummy
2021-09-30T19:36:55.5641107Z ##[group]Getting Git version info
2021-09-30T19:36:55.5642382Z Working directory is '/home/runner/work/ActionsReceiverDummy/ActionsReceiverDummy'
2021-09-30T19:36:55.5643711Z [command]/usr/bin/git version
2021-09-30T19:36:55.5644260Z git version 2.33.0
2021-09-30T19:36:55.5646030Z ##[endgroup]
2021-09-30T19:36:55.5647011Z Deleting the contents of '/home/runner/work/ActionsReceiverDummy/ActionsReceiverDummy'
2021-09-30T19:36:55.5649258Z ##[group]Initializing the repository
2021-09-30T19:36:55.5650111Z [command]/usr/bin/git init /home/runner/work/ActionsReceiverDummy/ActionsReceiverDummy
2021-09-30T19:36:55.5651251Z hint: Using 'master' as the name for the initial branch. This default branch name
2021-09-30T19:36:55.5653293Z hint: is subject to change. To configure the initial branch name to use in all
2021-09-30T19:36:55.5654090Z hint: of your new repositories, which will suppress this warning, call:
2021-09-30T19:36:55.5654687Z hint: 
2021-09-30T19:36:55.5655419Z hint: 	git config --global init.defaultBranch <name>
2021-09-30T19:36:55.5655982Z hint: 
2021-09-30T19:36:55.5656698Z hint: Names commonly chosen instead of 'master' are 'main', 'trunk' and
2021-09-30T19:36:55.5657682Z hint: 'development'. The just-created branch can be renamed via this command:
2021-09-30T19:36:55.5658305Z hint: 
2021-09-30T19:36:55.5659112Z hint: 	git branch -m <name>
2021-09-30T19:36:55.5659996Z Initialized empty Git repository in /home/runner/work/ActionsReceiverDummy/ActionsReceiverDummy/.git/
2021-09-30T19:36:55.5661158Z [command]/usr/bin/git remote add origin https://github.com/gabizou/ActionsReceiverDummy
2021-09-30T19:36:55.5662433Z ##[endgroup]
2021-09-30T19:36:55.5663460Z ##[group]Disabling automatic garbage collection
2021-09-30T19:36:55.5664263Z [command]/usr/bin/git config --local gc.auto 0
2021-09-30T19:36:55.5665242Z ##[endgroup]
2021-09-30T19:36:55.5667590Z ##[group]Setting up auth
2021-09-30T19:36:55.5668477Z [command]/usr/bin/git config --local --name-only --get-regexp core\.sshCommand
2021-09-30T19:36:55.5669898Z [command]/usr/bin/git submodule foreach --recursive git config --local --name-only --get-regexp 'core\.sshCommand' && git config --local --unset-all 'core.sshCommand' || :
2021-09-30T19:36:55.5671326Z [command]/usr/bin/git config --local --name-only --get-regexp http\.https\:\/\/github\.com\/\.extraheader
2021-09-30T19:36:55.5673064Z [command]/usr/bin/git submodule foreach --recursive git config --local --name-only --get-regexp 'http\.https\:\/\/github\.com\/\.extraheader' && git config --local --unset-all 'http.https://github.com/.extraheader' || :
2021-09-30T19:36:55.5674750Z [command]/usr/bin/git config --local http.https://github.com/.extraheader AUTHORIZATION: basic ***
2021-09-30T19:36:55.5676033Z ##[endgroup]
2021-09-30T19:36:55.5677003Z ##[group]Fetching the repository
2021-09-30T19:36:55.5678683Z [command]/usr/bin/git -c protocol.version=2 fetch --no-tags --prune --progress --no-recurse-submodules --depth=1 origin +f0afbe9a4cf081dc439d59de311060a984d88587:refs/remotes/origin/main
2021-09-30T19:36:55.5679938Z remote: Enumerating objects: 9, done.        
2021-09-30T19:36:55.5680514Z remote: Counting objects:  11% (1/9)        
2021-09-30T19:36:55.5681073Z remote: Counting objects:  22% (2/9)        
2021-09-30T19:36:55.5681794Z remote: Counting objects:  33% (3/9)        
2021-09-30T19:36:55.5682354Z remote: Counting objects:  44% (4/9)        
2021-09-30T19:36:55.5682907Z remote: Counting objects:  55% (5/9)        
2021-09-30T19:36:55.5683445Z remote: Counting objects:  66% (6/9)        
2021-09-30T19:36:55.5683996Z remote: Counting objects:  77% (7/9)        
2021-09-30T19:36:55.5684529Z remote: Counting objects:  88% (8/9)        
2021-09-30T19:36:55.5685082Z remote: Counting objects: 100% (9/9)        
2021-09-30T19:36:55.5685650Z remote: Counting objects: 100% (9/9), done.        
2021-09-30T19:36:55.5686245Z remote: Compressing objects:  16% (1/6)        
2021-09-30T19:36:55.5686832Z remote: Compressing objects:  33% (2/6)        
2021-09-30T19:36:55.5687405Z remote: Compressing objects:  50% (3/6)        
2021-09-30T19:36:55.5687996Z remote: Compressing objects:  66% (4/6)        
2021-09-30T19:36:55.5688575Z remote: Compressing objects:  83% (5/6)        
2021-09-30T19:36:55.5689166Z remote: Compressing objects: 100% (6/6)        
2021-09-30T19:36:55.5689779Z remote: Compressing objects: 100% (6/6), done.        
2021-09-30T19:36:55.5690639Z remote: Total 9 (delta 0), reused 5 (delta 0), pack-reused 0        
2021-09-30T19:36:55.5691440Z From https://github.com/gabizou/ActionsReceiverDummy
2021-09-30T19:36:55.5692833Z  * [new ref]         f0afbe9a4cf081dc439d59de311060a984d88587 -> origin/main
2021-09-30T19:36:55.5694073Z ##[endgroup]
2021-09-30T19:36:55.5695066Z ##[group]Determining the checkout info
2021-09-30T19:36:55.5696066Z ##[endgroup]
2021-09-30T19:36:55.5697003Z ##[group]Checking out the ref
2021-09-30T19:36:55.5697858Z [command]/usr/bin/git checkout --progress --force -B main refs/remotes/origin/main
2021-09-30T19:36:55.5698678Z Switched to a new branch 'main'
2021-09-30T19:36:55.5699447Z Branch 'main' set up to track remote branch 'main' from 'origin'.
2021-09-30T19:36:55.5700482Z ##[endgroup]
2021-09-30T19:36:55.5701126Z [command]/usr/bin/git log -1 --format='%H'
2021-09-30T19:36:55.5701981Z 'f0afbe9a4cf081dc439d59de311060a984d88587'
2021-09-30T19:36:55.5779754Z ##[group]Run docker/login-action@v1
2021-09-30T19:36:55.5780414Z with:
2021-09-30T19:36:55.5780847Z   registry: ghcr.io
2021-09-30T19:36:55.5781300Z   username: gabizou
2021-09-30T19:36:55.5782170Z   password: ***
2021-09-30T19:36:55.5782604Z   logout: true
2021-09-30T19:36:55.5782992Z env:
2021-09-30T19:36:55.5783440Z   REPOSITORY: ghcr.io
2021-09-30T19:36:55.5783996Z   BASE_IMAGE: gabizou/golang-ci-actions
2021-09-30T19:36:55.5784531Z ##[endgroup]
2021-09-30T19:36:55.6221065Z Logging into ghcr.io...
2021-09-30T19:36:56.0752619Z Login Succeeded!
2021-09-30T19:36:56.1008730Z ##[group]Run echo 
2021-09-30T19:36:56.1009248Z [36;1mecho [0m
2021-09-30T19:36:56.1010315Z [36;1mdocker pull ghcr.io/gabizou/golang-ci-actions@sha256:d1b20d86a87def89612a8842839ec5131aba5b75d961a57de808baa910118855[0m
2021-09-30T19:36:56.1056830Z shell: /usr/bin/bash -e {0}
2021-09-30T19:36:56.1057218Z env:
2021-09-30T19:36:56.1057622Z   REPOSITORY: ghcr.io
2021-09-30T19:36:56.1058139Z   BASE_IMAGE: gabizou/golang-ci-actions
2021-09-30T19:36:56.1058646Z ##[endgroup]
2021-09-30T19:36:56.1133889Z 
2021-09-30T19:36:57.1301776Z ghcr.io/gabizou/golang-ci-actions@sha256:d1b20d86a87def89612a8842839ec5131aba5b75d961a57de808baa910118855: Pulling from gabizou/golang-ci-actions
2021-09-30T19:36:57.1303090Z 29291e31a76a: Pulling fs layer
2021-09-30T19:36:57.1303573Z e4bc8fc554c3: Pulling fs layer
2021-09-30T19:36:57.1304053Z 803daa35ea47: Pulling fs layer
2021-09-30T19:36:57.1304808Z 38284154e396: Pulling fs layer
2021-09-30T19:36:57.1305249Z a66f7597198a: Pulling fs layer
2021-09-30T19:36:57.1305798Z c4ecb9e27818: Pulling fs layer
2021-09-30T19:36:57.1306211Z 38284154e396: Waiting
2021-09-30T19:36:57.1306752Z a66f7597198a: Waiting
2021-09-30T19:36:57.1307145Z c4ecb9e27818: Waiting
2021-09-30T19:36:57.1307607Z 803daa35ea47: Download complete
2021-09-30T19:36:57.1308099Z 29291e31a76a: Verifying Checksum
2021-09-30T19:36:57.1308554Z 29291e31a76a: Download complete
2021-09-30T19:36:57.1309048Z e4bc8fc554c3: Verifying Checksum
2021-09-30T19:36:57.1309585Z e4bc8fc554c3: Download complete
2021-09-30T19:36:57.1310071Z 29291e31a76a: Pull complete
2021-09-30T19:36:57.1310553Z a66f7597198a: Verifying Checksum
2021-09-30T19:36:57.1311035Z e4bc8fc554c3: Pull complete
2021-09-30T19:36:57.1311501Z 803daa35ea47: Pull complete
2021-09-30T19:36:58.1311136Z c4ecb9e27818: Verifying Checksum
2021-09-30T19:36:58.1319804Z c4ecb9e27818: Download complete
2021-09-30T19:36:58.1320823Z 38284154e396: Verifying Checksum
2021-09-30T19:36:58.1321400Z 38284154e396: Download complete
2021-09-30T19:37:02.6904666Z 38284154e396: Pull complete
2021-09-30T19:37:02.7464595Z a66f7597198a: Pull complete
2021-09-30T19:37:04.5924600Z c4ecb9e27818: Pull complete
2021-09-30T19:37:04.6004232Z Digest: sha256:d1b20d86a87def89612a8842839ec5131aba5b75d961a57de808baa910118855
2021-09-30T19:37:04.6021803Z Status: Downloaded newer image for ghcr.io/gabizou/golang-ci-actions@sha256:d1b20d86a87def89612a8842839ec5131aba5b75d961a57de808baa910118855
2021-09-30T19:37:04.6041835Z ghcr.io/gabizou/golang-ci-actions@sha256:d1b20d86a87def89612a8842839ec5131aba5b75d961a57de808baa910118855
2021-09-30T19:37:04.6133779Z Post job cleanup.
2021-09-30T19:37:04.6582853Z [command]/usr/bin/docker logout ghcr.io
2021-09-30T19:37:04.6924819Z Removing login credentials for ghcr.io
2021-09-30T19:37:04.7090085Z Post job cleanup.
2021-09-30T19:37:04.8019143Z [command]/usr/bin/git version
2021-09-30T19:37:04.8058609Z git version 2.33.0
2021-09-30T19:37:04.8089198Z [command]/usr/bin/git config --local --name-only --get-regexp core\.sshCommand
2021-09-30T19:37:04.8120666Z [command]/usr/bin/git submodule foreach --recursive git config --local --name-only --get-regexp 'core\.sshCommand' && git config --local --unset-all 'core.sshCommand' || :
2021-09-30T19:37:04.8343376Z [command]/usr/bin/git config --local --name-only --get-regexp http\.https\:\/\/github\.com\/\.extraheader
2021-09-30T19:37:04.8363854Z http.https://github.com/.extraheader
2021-09-30T19:37:04.8373632Z [command]/usr/bin/git config --local --unset-all http.https://github.com/.extraheader
2021-09-30T19:37:04.8401986Z [command]/usr/bin/git submodule foreach --recursive git config --local --name-only --get-regexp 'http\.https\:\/\/github\.com\/\.extraheader' && git config --local --unset-all 'http.https://github.com/.extraheader' || :
2021-09-30T19:37:04.8657583Z Cleaning up orphan processes
```
</details>

[ActionsReceiverDummy]:https://github.com/gabizou/ActionsReceiverDummy
[repository_dispatch]:https://docs.github.com/en/actions/learn-github-actions/events-that-trigger-workflows#repository_dispatch
