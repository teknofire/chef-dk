#!/bin/sh
#
# After a PR merge, Chef Expeditor will bump the PATCH version in the VERSION file.
# It then executes this file to update any other files/components with that new version.
#

set -evx

# The github-changelog-generator requires that LANG be set
export LANG=en_US.UTF-8

# We need to run a bundle install so that our `bundle exec rake` command will work.
. .expeditor/bundle_install.sh

# Run a rake command that will update various files in chef/chef-dk with the new VERSION
bundle exec rake expeditor_update_version

# Our `rake` command can sometimes modify this file, but we don't care about the
# changes it makes. Reset it to HEAD.
git checkout .bundle/config

# Once Expeditor finshes executing this script, it will commit the changes and push
# the commit as a new tag corresponding to the value in the VERSION file.
