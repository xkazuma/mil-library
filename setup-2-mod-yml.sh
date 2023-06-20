# Set temporal variables
PROJECT=mil-library

if [ -z "$PROJECT" ]; then
  echo "set your project name (directory name) into variable PROJECT."
  exit 1
fi

# Modifying docker-compose.yml
cp docker-compose.yml docker-compose.yml.bak
cp Dockerfile Dockerfile.bak
sed -i '/##DELETE##/d' docker-compose.yml \
  && sed -i -e 's/^#//' docker-compose.yml \
  && sed -i -e "s/PROJECT/$PROJECT/" docker-compose.yml
sed -i -e 's/^#COPY/COPY/' Dockerfile \
  && sed -i -e "s/PROJECT/$PROJECT/" Dockerfile
