#!/usr/bin/perl -w
use strict; use warnings;

=head1 检查commit的内容，拒绝敏感字符串

# 如何使用：
# 1. 把本文件放到.git/hooks/目录下，改名为pre-commit
# 2. chmod +x .git/hooks/pre-commit
# 或者将文件放在一个地方，ln 过去 ln /var/share/pre-commit-reject-content.pl .git/hooks/pre-commit
# 如何调试
找一个仓库，改点东西，stage之。
然后人工执行这个脚本，看看输出是什么。

或者把qx/git diff/ 里面的内容改了，直接运行看结果。例如：git diff 96764d9003dcc31d6910251f24f3c20d1fbcfaa0 env.default

=cut

# Get the diff of staged changes
my @diff_lines = qx/git diff --cached/;

my @signal = ('APP_ID','APP_SECRET');
# for each line in diff ; check for the special string
my $file = "";
foreach (@diff_lines) {
  chomp;
  if(m/^diff --git a\/(.*?) b\/(.*?)/){
    $file = $2;
  }elsif(m/^index /){
    #skip
  }elsif(m/^\-\-\- /){
    #指示左边文件-
  }elsif(m/^\+\+\+ /){
    #指示右边文件+
  }elsif(m/^@@ /){
    #替换位置
  }elsif(m/^\s/){
    #左边文件特征
  }elsif(m/^-/){
    #左边减去的内容
  }elsif(m/^\\ /){
    #其他注解
  }elsif(m/^\+/){
    #右边增加的内容
    my $etc = substr($_,1);
    foreach my $key (@signal) {
      if ($etc =~ /^$key=/) {
        #print "检测到敏感字符串：$etc\n";
        #replace APP_ID=
        $etc =~ s/$key=//g;
        #print "替换后的内容：$etc\n";
        if($etc eq'TODO'){
        #It's Ok.
        }else{
          print "== 告警 ==\n 按规则，机密信息串不能直接入库，应当改为占位符。形如：$key=TODO\n";
          exit 1;
        }
      }
    }
  }else{
    #UNKNOWN;
  }
}


# Sample diff input
# diff --git a/env.default b/env.default
# index 1728692..b34e337 100644
# --- a/env.default
# +++ b/env.default
# @@ -1,3 +1,10 @@
#  APP_SECRET=TODO
#  APP_ID=TODO
# -PORT=8848
# \ No newline at end of file
# +PORT=8848
# +KEYCLOAK_BASE_URL=http://localhost:8089
# +KEYCLOAK_REALM_NAME=leansd
# +KEYCLOAK_ADMIN_CLIENT_ID=admin-cli
# +KEYCLOAK_ADMIN_USERNAME=admin
# +KEYCLOAK_ADMIN_PASSWORD=admin
# +KEYCLOAK_NEW_USER_DEFAULT_PASSWORD=!7b480105be848@e81277b5a10ca30
# +KEYCLOAK_AUTH_CLIENT_ID=cotrip
# \ No newline at end of file