FROM bressani/rails:6.0.0.beta3

# Project Config
RUN mkdir /quacker
WORKDIR /quacker
COPY Gemfile /quacker/Gemfile
COPY Gemfile.lock /quacker/Gemfile.lock

RUN bundle install

COPY . /quacker

RUN [ -f package-lock.json ] && rm package-lock.json || echo "package-lock.json not created"

RUN rm -rf quacker/public/assets

RUN yarn install --check-files
RUN bundle exec rails webpacker:install

EXPOSE 3000

# # Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]
