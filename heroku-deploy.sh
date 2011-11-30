#!/usr/bin/env sh
echo "gem 'pg'" >> Gemfile
bundle exec rake assets:precompile
bundle
git add .
git commit -m "Precompile assets; add postgre adapter"
git push heroku master --force
git reset HEAD^1
rm -rf public/assets
git checkout .

