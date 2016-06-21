#!/bin/sh

install_config(){

	cat > ~/.gitconfig  <<'EOF'
[user]
        name = luomg
        email = luomgf@163.com
[push]
        default = matching
[core]
        trustctime = false
        quotepath = false
        autocrlf = false
[merge]
        conflictstyle = diff3
[credential]
        helper = store
[i18n]
        commitencoding = utf-8
        #logoutputencoding = gbk  #*nix,utf-8; windows,gbk
[gui]
        encoding = utf-8
        recentrepo = E:/data/world/code/myworld
[svn]
     pathnameencoding = GB2312

[color]
        ui = true
[alias]
    st = status 
    co = checkout 
    br = branch 
    mg = merge 
    ci = commit 
    ds = diff --staged 
    dt = difftool 
    mt = mergetool 
    last = log -1 HEAD 
    latest = for-each-ref --sort=-committerdate --format='%(committername)@%(refname:short) [%(committerdate:short)] %(contents)' 
    ls = log --pretty=format:'%C(yellow)%h %C(blue)� %C(red)%d %C(reset)%s %C(green)[%cn]' --decorate --date=short 
    hist = log --pretty=format:'%C(yellow)%h %C(red)%d %C(reset)%s %C(green)[%an] %C(blue)' --topo-order --graph --date=short 
    type = cat-file -t 
    dump = cat-file -p 
    graph = log --graph --pretty=format:'%C(yellow)%h %C(blue)%d %C(reset)%s %C(white)%an, %ar%C(reset)'
EOF
}

install_completion(){
	 curl  -O   https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash 
	\mv  git-completion.bash  ~/.git-completion.bash 
	grep  git-completion.bash ~/.bash_profile  || {
		echo '
	if [ -f ~/.git-completion.bash ]; then
                 . ~/.git-completion.bash
       fi
'  >>  ~/.bash_profile 	
	
	}
}

	install_completion
