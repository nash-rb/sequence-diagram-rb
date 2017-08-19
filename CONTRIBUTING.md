# Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/nash-rb/sequence_diagram. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## Recommended Workflow
     If you are not in the nash-rb org, you'll need to fork the repo first.

### Sync with remote ###

     git checkout master
     git pull 

### Checkout a new feature branch ###
     git checkout -b <branchname>

### Make incremental changes ###

     git add
     git commit -m "description of changes"

### Squash commits down to minimal needed

     git rebase -i master

### Ensure tests pass ###

     bundle exec rake test

### Ensure style is correct ###

     bundle exec rubocop

### Push changes to remote feature branch ###

     git push origin <branchname>

### Submit the Pull Request on GitHub ###

    - Once any requested changes are complete, you may need to squash and push again. 
    - At this point the PR will be approved and merged to master.

### Notes ###
    - It is a good idea to make small commits and push to the remote feature branch regularly. You can always squash them before submitting a PR.
    - Feel free to submit a PR as a way of getting help or feedback. Be sure to note that intention in the description.
    - Only fast-forward merges will be done to master. 