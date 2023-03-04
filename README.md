# GitHub Action for exporting JSONResume

This action exports your resume in [JSONResume](https://jsonresume.org/) to **HTML** and **PDF**.

This can be combined with other actions to publish your resume as a Github page.

> Example: https://kelvintaywl.github.io/resume

## Inputs

| Name | Description | Default |
| --- | --- | --- |
| theme | JSONResume theme name. See https://jsonresume.org/themes/ | `flat` |
| resume_filepath | file path to your resume in JSONResume format | `resume.json` |
| output_filepath | output file path | `index` |

## Example Workflows

### To publish your resume as a Github page

> This example assumes you have a resume.json at the **root directory of your repository**. 

> In addition, this assumes you have set up your GitHub pages on this repository [to reference the `docs/` folder as your source](https://docs.github.com/en/free-pro-team@latest/github/working-with-github-pages/configuring-a-publishing-source-for-your-github-pages-site#choosing-a-publishing-source).

```yaml
# example GitHub workflow

name: Publish resume as Github Page

on:
  push:
    branches: [ master ]
  workflow_dispatch:

permissions:
  contents: read
  pages: write
  id-token: write

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - name: Check out your repository using git
        uses: actions/checkout@v2
        
      - name: Export resume.json as HTML and PDF 
        uses: lexbrugman/action-jsonresume-export@master
        with:
          resume_filepath: resume.json
          output_filepath: docs/index
          
      - name: Upload artifact
        uses: actions/upload-pages-artifact@v1
        with:
          path: docs

  deploy:
    runs-on: ubuntu-latest
    needs: build
    environment:
      name: github-pages
      url: ${{ steps.deployment.outputs.page_url }}
    steps:
      - name: Deploy to GitHub Pages
        id: deployment
        uses: actions/deploy-pages@v1
```

## Why?

Good question indeed!

In fact, you may already noticed JSONResume provides a [hassle-free hosting service to export and collate your resume already](https://jsonresume.org/getting-started/).

However, I made this action because:

1. Using a specific theme that is not supported [requires the JSONResume team to add the theme as dependency to their solutions](https://github.com/jsonresume/registry-functions/issues/7); I wanted to keep the export dependency lean with just the theme I need for my case.

2. This solution allow me to centrally keep a resume in both the JSON format as well as publishing it in HTML and PDF as a GitHub page easily.

3. I wanted to learn more about creating and writing Github Actions :robot:
