'use strict'

scriptName = process.argv[3] or 'run'
repoUrl = process.argv[2]
repoName = repoUrl.split('/').join '-'
repoArray = repoName.split '-'
repoArray.shift() if repoArray[0] is repoArray[1]
repoName = repoArray.join '-'

script = [
  "touch #{scriptName}"
  "cat > #{scriptName} <<EOR"
  'git remote rm origin'
  "git remote add origin git@#{repoName}.github.com:#{repoUrl}.git"
  "ssh-keygen -t rsa -f ~/.ssh/id_rsa-#{repoName} -C https://github.com/#{repoUrl}"
  "ssh-add ~/.ssh/id_rsa-#{repoName}"
  "pbcopy < ~/.ssh/id_rsa-#{repoName}.pub"
  'touch ~/.ssh/config'
  'cat >> ~/.ssh/config <<EOS'
  "Host #{repoName}.github.com"
  '  Hostname github.com'
  "  IdentityFile ~/.ssh/id_rsa-#{repoName}"
  ''
  'EOS'
  "rm #{scriptName}"
  'EOR'
]

script.forEach (line) ->
  console.log line
