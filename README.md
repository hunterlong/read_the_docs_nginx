# Read The Docs Nginx Docker

This Docker image will create simple Documentation base on [Sphinx Read The Docs Theme](https://github.com/snide/sphinx_rtd_theme). You can mount your docs source to this image, or you can pull from your public and/or private github. 


### Mounting Docs
Mount your volume to '/root/docs_source' and it will automatically be generated on startup.
```bash
docker run -it -v /var/mydocs:/root/docs_source -p 80:80 hunterlong/read_the_docs_nginx
```

### Docs From Public Github Repo
'DOCS_FOLDER' should equal the folder inside the repo that holds the documentation (*.rst). You can remove this if the repo is just the documentation. 
```bash
docker run -it -p 80:80 \
  -e "GITHUB_REPO=hunterlong/read_the_docs_nginx" \
  -e "GIT_BRANCH=master" \ 
  -e "DOCS_FOLDER=docs" \ 
  hunterlong/read_the_docs_nginx
```

### Docs From Private Github Repo
You can generate a Personal Token from Github. [https://help.github.com/articles/creating-an-access-token-for-command-line-use/](https://help.github.com/articles/creating-an-access-token-for-command-line-use/)
```bash
docker run -it -p 80:80 \
  -e "GITHUB_REPO=hunterlong/read_the_docs_nginx" \
  -e "GIT_BRANCH=master" \ 
  -e "GIT_USERNAME=mygithubuser" \ 
  -e "GIT_PERSONAL_TOKEN=h7d9ka82ihjd929jd38hfhaiqnc" \ 
  -e "GIT_BRANCH=master" \ 
  -e "DOCS_FOLDER=docs" \ 
  hunterlong/read_the_docs_nginx
```
