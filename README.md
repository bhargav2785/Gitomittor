What is Gitomittor?
===
Gitomittor is made of two words `Git + Commitor`. It is simply a shell script that runs bunch of commands and finds most commited files as well as top commitor on those files.

Where can we use Gitomittor?
===
There are often times when we need to find out, in given git repository, what are the hot files in terms of most number of commits. Sometimes it is required to find out who is the top commitor author for a given git repository. Well, this is where Gitomittor comes for help.

You just need to run gitommitor.sh against preferred git repository. It runs couple of git commands and outputs top files together with top commitors on those files. See below for options.

Options/Arguments
===
gitommitor.sh takes following artuments in order

1. required, git directory location
2. required, number of top commited files
3. optional, comma separated file types 

So at least first two arguments are required otherwise it will fail. First argument is the git repo location itself. Second argument is number of top committed files. Third argument is optional, which is comma separated list of file types. So for example, if you want the operation performed only on .js, .php and .css files you will pass the third argument as **js,php,css**. If you don't pass anything on third argument, the script will use the default list of file types which is **py,php,js,scss,css,feature,txt,tpl**. You can change it as per requirement.

Examples
===
1. `./gitommitor.sh /path/to/git/repo/ 10 php,js,css`
2. `./gitommitor.sh /path/to/git/repo/ 5 py`
3. `./gitommitor.sh /path/to/git/repo/ 20`

Installation
===
`git clone https://github.com/bhargav2785/Gitomittor`