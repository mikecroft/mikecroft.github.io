
export JEKYLL_VERSION=3.8
docker run --rm \
  --name jekyll-server \
  -p 4000:4000 \
  --volume="$PWD:/srv/jekyll" \
  --volume="$PWD/vendor/bundle:/usr/local/bundle" \
  -it jekyll/jekyll:$JEKYLL_VERSION \
  jekyll serve --drafts --watch
