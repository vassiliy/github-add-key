# github-add-key

Tiny funny automation for GitHub multiple deploy keys management.

Inspired by [this](http://stackoverflow.com/a/12705155/7065203) great StackOverflow answer by [aculich](http://stackoverflow.com/users/462302/aculich).

### Usage

Install this globally:

```bash
npm install -g github-add-key
```
Clone your repo , `cd` into it, then

```bash
github-add-key <your GitHub repo url tail> <script name>
```

**your GitHub repo url tail** for this repo would be `vassiliy/github-add-key`.

Default **script name** is `run`, but you can choose whatever valid name if you care. Last line of this script deletes its file anyway.

Then tiny funny automation magic starts:

```bash
$ github-add-key yourcoolorg/yourcoolorg-your-amazing-repo
touch run
cat > run <<EOR
git remote rm origin
git remote add origin git@yourcoolorg-your-amazing-repo.github.com:yourcoolorg/yourcoolorg-your-amazing-repo.git
ssh-keygen -t rsa -f ~/.ssh/id_rsa-yourcoolorg-your-amazing-repo -C https://github.com/yourcoolorg/yourcoolorg-your-amazing-repo
ssh-add ~/.ssh/id_rsa-yourcoolorg-your-amazing-repo
pbcopy < ~/.ssh/id_rsa-yourcoolorg-your-amazing-repo.pub
touch ~/.ssh/config
cat >> ~/.ssh/config <<EOS
Host yourcoolorg-your-amazing-repo.github.com
  Hostname github.com
  IdentityFile ~/.ssh/id_rsa-yourcoolorg-your-amazing-repo

EOS
rm run
EOR
$
```

Then you check with your own eyes that this script is exactly what you wish to run, copy this right from `touch run` right to `EOR` to command prompt and hit `Enter`!

Then you get the script file `run` which will:

- redefine your local repo's `origin` for deploy key usage,
- guide you through all the custom ssh deploy key creation process,
- place into clipboard the public key ready for adding to GitHub,
- add stanza for this key into your `~/.ssh/config`,
- finally delete itself.

Check it by `cat run` or even edit some more coolness into it if you wish.

Then you

```bash
sh run
```

it, enter the same passphrase for the new key thrice and go your GitHub repo's settings to add this brand new key manually with whatever rights you want. You remember, public key is already in your clipboard.

Your local setup is ready for deploy, no intermediate files left.
