# Dockerized self-hosted GitHub runner

## Local development
- Build docker image: `docker build -t gh-runner .`
- Set environment variables in .env file:
    - OWNER - GitHub's repository owner
    - REPO - Git repository in GitHub
    - PAT - Personal Access Token with repo rights
- Run image with `docker run -ti --rm --env-file .env gh-runner`

## TO-DO Links
1. [kaniko](https://github.com/GoogleContainerTools/kaniko) - Docker image build on Kubernetes
1. [argo-cd](https://github.com/argoproj/argo-cd) - Continuous Delivery for Kubernetes