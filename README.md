# GitHub's self-hosted runner

## Usage
- Build docker image: `docker build -t actions-image .`
- Set environment variables:
    - OWNER - GitHub's owner
    - REPO - Git repository in GitHub
    - PAT - Personal Access Token with repo rights
- Run image with `docker run -ti --rm actions-image -o ${OWNER} -r ${REPO} -p ${PAT}`


## TO-DO Links
1. [kaniko](https://github.com/GoogleContainerTools/kaniko) - docker image build
1. [argo-cd](https://github.com/argoproj/argo-cd) - Continuous Delivery for Kubernetes