FROM 414846394997.dkr.ecr.us-east-1.amazonaws.com/b2b-base:latest

WORKDIR /project

COPY . ./
RUN gem install bundler && bundle install --jobs 20 --retry 5 && yarn install
ENTRYPOINT sh run.sh
EXPOSE 3000
