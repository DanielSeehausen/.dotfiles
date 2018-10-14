# this won't pull the first line if provided inline with the command
pullAll() {
  while read line; do
    git clone $line
    sleep 2
  done
}

help () {
  say yeah i program in java! &&
  say just
  say help me please ive been stuck in this enterprise dev job for the past five years and I am slowly deteriorating
  say this isnt a meme its a legitimate call for help
}

gitgimme () {
  git branch -r | grep -v '\->' | while read remote; do git branch --track "${remote#origin/}" "$remote"; done
  git fetch --all
  git pull --all
}

updateGitIgnore () {
  if [ -e "./.gitignore" ]; then
    echo ".gitignore PRESENT"
    :
  else
    touch .gitignore
    git add .
    git commit -m "AUTO: added .gitignore"
    echo ".gitignore ABSENT: ADDED"
  fi

  if ! grep -q "Gemfile.lock" .gitignore; then
    echo "ADDING .lock file to .gitignore"
    echo "Gemfile.lock" >> .gitignore
  fi
  # corner case
  if grep -q "# Gemfile.lock" .gitignore; then
    echo ".lock commented out in .gitignore -- removing comment!"
    sed -e "s/# Gemfile.lock/Gemfile.lock/" .gitignore > .gitignore.temp && mv .gitignore.temp .gitignore
  fi
}

removeLockFile () {
  if [ -e "./Gemfile.lock" ]; then
    echo "Gemfile.lock PRESENT: REMOVING"
    rm Gemfile.lock
    git add .
    git status
    git commit -m "AUTO: removed Gemfile.lock"
    echo "sleep 2"
    sleep 2
    echo "UNTRACKING Gemfile.lock"
    git rm -f Gemfile.lock
  else
    echo "Gemfile.lock ABSENT"
  fi
}

updateGems () {
  if grep -Fq "gem 'rails'," Gemfile
  then
    echo "RAILS GEM FOUND: UPDATING TO '~> 4.2"
    # find any line with (gem 'rails', 'XXXXXX') and replace with (gem 'rails', '~> 4.2'). Before and after the replace stays the same so we don't cut off specifications
    # a safety precaution is in here: we we write to a temp file, then replace the original with that. This makes it so, if the sed fails for some reason, the original Gemfile is copied back on itself instead of destroyed/corrupted
    sed -e "s/gem 'rails', '\(.*\)'/gem 'rails', '~> 4.2'/g" Gemfile > Gemfile.temp && mv Gemfile.temp Gemfile
    echo "REMOVING WEB CONSOLE GEM IF PRESENT"
    sed -e "/gem 'web-console'/d" Gemfile > Gemfile.temp && mv Gemfile.temp Gemfile
  fi

  # update rspec rails version
  if grep -Fq "gem 'rspec-rails'," Gemfile
  then
    echo "RSPEC-RAILS GEM FOUND: UPDATING TO ~> 3.7"
    sed -e "s/gem 'rspec-rails', '\(.*\)'/gem 'rspec-rails', '~> 3.7'/g" Gemfile > Gemfile.temp && mv Gemfile.temp Gemfile
  fi
}

update () {
  if ! [ -e "./Gemfile" ]; then
    echo "NO GEMFILE PRESENT -- NOT UPDATING..."
    return
  fi

  # make .gitignore if absent
  # ...and add Gemfile.lock to .gitignore if not present
  echo -e "\nupdateGitIgnore()...\n"
  updateGitIgnore
  echo -e "...\n\n"

  # delete the lock file if it was brought down
  echo -e "\nremoveLockFile()...\n"
  removeLockFile
  echo -e "...\n\n"

  # update rails version in gemfile if present -- removes breaking web console
  echo -e "\nupdateGems()...\n"
  updateGems
  echo -e "...\n\n"

  git add .
  git commit -m "AUTO UPDATE -- if not already done: updated rails version, updated rspec-rails, added .gitignore, added .lock to .gitignore, untracked .lock and removed"
  echo -e "\nFINISHED UPDATING...SLEEPING 3\n"
  sleep 3

  echo -e "\n\n"
  read -n 1 -s -r -p "FINISHED...Press any key to push!"
  git push
}


updateAll () {
  for D in *; do
    if [ -d "${D}" ]; then
        echo -e "\n\nPROCESSING: ${D}"   # your processing here
        cd ${D}
        update
        echo "\n\n...FINISHED"
        echo "SLEEP 2"
        sleep 2
        cd ..
        clear
    fi
  done
}

# iirc was running this to make sure all labs were updated in the script i ran
printLastCommit () {
  for D in *; do
    if [ -d "${D}" ]; then
        echo -e "\n\nPROCESSING: ${D}"   # your processing here
        cd ${D}
        git rev-list --format=format:'%ai' --max-count=1 `git rev-parse HEAD`
        echo " "
        cd ..
        read -n 1 -s -r -p "FINISHED...Press any key to push!"
        clear
    fi
  done
}

#  just use as template for now sloppy dop
forEveryDirectory () {
  for D in *; do
    if [ -d "${D}" ]; then
        printf '=%.0s' {1..100}
        echo -e "\n\t\t\tPROCESSING: ${D}"   # your processing here
        cd ${D} > /dev/null

        # meat here

        read -n 1 -s -r -p "FINISHED...Press any key to..."
        cd .. > /dev/null
        clear
    fi
  done
}

checkForSolutions () {
  for D in *; do
    if [ -d "${D}" ]; then
        printf '=%.0s' {1..100}
        echo -e "\n\t\t\tPROCESSING: ${D}"   # your processing here
        cd ${D} > /dev/null

        remote_url=`git remote get-url origin 2>&1`
        result=`git ls-remote --heads ${remote_url} solution | wc -l`
        if [ "$result" -eq 0 ]; then
          printf '*%.0s' {1..30}
          printf "\nMISSING SOLUTION FOR: ${remote_url}\n"
          printf '*%.0s' {1..30}
          echo ""
        fi

        cd .. > /dev/null
        read -n 1 -s -r -p "Go next? Press any key"
        clear
    fi
  done
}

# goes through all labs section/sub-section/lab
# checks if solution exists. if so, switches into it
ppp () {
  for D in *; do
    printf '=%.0s' {1..100}
    echo -e "\n\t\t\tSECTION PROCESSING: ${D}"
    cd ${D} > /dev/null
    for D in *; do
      if [ -d "${D}" ]; then

        printf '=%.0s' {1..100}
        echo -e "\n\t\t\tPROCESSING: ${D}"
        cd ${D} > /dev/null
        git co master
        if [ `git branch -a | egrep 'remotes/origin/solution$'` ]
        then
           echo "SOLUTION FOUND HESLKFNSNKLFSKNFLKSNFRE"
           git co solution
        fi

        # open https://github.$(git config remote.origin.url | cut -f2 -d.)
        cd .. > /dev/null
        read -n 1 -s -r -p "Go next? Press any key"
      fi
    done
    cd .. > /dev/null
    read -n 1 -s -r -p "Go next SECTION??? Press any key"
  done
}
