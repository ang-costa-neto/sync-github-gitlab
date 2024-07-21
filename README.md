# Sync GitHub with Other Repository Managements (e.g., GitLab)

This project was created to mirror GitHub repositories with other service repositories.

## How to Use This Action

1. In your repository, create secrets by navigating to `Settings > Secrets and variables > Actions`.
2. On the Secrets tab, click on `New repository secret`.
3. Then create the following secrets:
    - **TARGET_TOKEN**
        - This secret is the access token from the other repository management service.
    - **TARGET_URL**
        - This secret is the URL for cloning using HTTPS from the other repository management service.
    - **TARGET_USERNAME**
        - This secret is the username from the other repository management service.
4. In your GitHub repository, create a workflow using the template below. If you do not know how to do this, [follow the instructions below](https://github.com/ang-costa-neto/sync-github-gitlab/tree/main?tab=readme-ov-file#how-to-create-a-workflow-in-the-current-repository):
    ```yml
    name: GitLabSync

    on:
      push

    jobs:
      sync:
        runs-on: ubuntu-latest
        name: Git Repo Sync
        steps:
        - uses: actions/checkout@v2
          with:
            fetch-depth: 0
        - uses: ang-costa-neto/sync-github-gitlab@<latest-version>
          with:
            target-url: ${{ secrets.TARGET_URL }}
            target-username: ${{ secrets.TARGET_USERNAME }}
            target-token: ${{ secrets.TARGET_TOKEN }}
    ```
5. Then `push` your changes to your repository, and follow the progress on the `Actions` tab in your GitHub repository.

## How to Create a Workflow in the Current Repository

1. Create a folder called `.github` in the root directory of your project.
2. Inside the `.github` folder, create another folder called `workflows`.
3. In the `workflows` folder, create your YAML files for actions.
