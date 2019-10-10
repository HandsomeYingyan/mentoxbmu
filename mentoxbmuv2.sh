#!/bin/bash
 
ipad="`/sbin/ifconfig -a|grep inet|grep -v 127.0.0.1|grep -v inet6|awk '{print $2}'|tr -d "addr:"`"
hostname="`hostname --fqdn`"
debug=0
zero=0
function menu()
{
     
echo "----------------------------------"
echo "西北民大恨校园电信校园网（mentoxbmu）客户端 shell版"
echo "handsomehacker(c)2019 服从gplv3协议"
echo "依赖curl 合理使用  搞事被抓  我不负责"
echo "(0) 给你发个验证短信（得到token）"
echo "(1) 登录"
echo "(2) 退出这个舞台！"
echo "(3) 查看被禁用硬件特征码（没用）"
echo "(4) 修改IP地址"
echo "(5) 退出程序"
echo "(6) 打开哆嗦模式（显示服务器回复信息)"
echo "(7) 显示所有变量的值"
echo "----------------------------------"
echo "你现在的ip地址为$ipad"
echo "你现在的主机名为$hostname"
echo "输入你的操作！"

read input
 
case $input in
    0)
    echo "输入你的手机号码！"
    read phone
    if [ "$debug" = "$zero" ];then
    ph="`curl http://61.178.5.73/rasPortal/getSms.do?req=%7B%22mobile%22%3A%22$phone%22%7D`"
    tok=${ph:75:64}
    res=${ph:148:9}
    echo $tok >./tok.log
     echo $res
    else
    curl http://61.178.5.73/rasPortal/getSms.do?req=%7B%22mobile%22%3A%22$phone%22%7D
    fi
    sleep 5
          clear
          menu
            ;;
    1)
    echo "输入你的手机号码！"
    read phone
    echo "输入你的密码！"
    read password
    token=$(cat ./tok.log)
    if [ "$debug" = "$zero" ];then
    lo="`curl http://61.178.5.73/rasPortal/userAuth.do?req=%7B%22user_name%22%3A%22$phone%22%2C%22password%22%3A%22$password%22%2C%22token_id%22%3A%22$token%22%2C%22user_ip%22%3A%22$ipad%22%2C%22bas_name%22%3A%22GS-LZ-YZ-BAS-1.MAN.NE40-X16%22%2C%22client_type%22%3A%22PC%22%2C%22device_name%22%3A%22Win10%22%2C%22client_version%22%3A%2219.04.01%22%7D`"
         echo $lo
         sid=${lo:15:32}
          echo $sid>./id.log
     else
     curl http://61.178.5.73/rasPortal/userAuth.do?req=%7B%22user_name%22%3A%22$phone%22%2C%22password%22%3A%22$password%22%2C%22token_id%22%3A%22$token%22%2C%22user_ip%22%3A%22$ipad%22%2C%22bas_name%22%3A%22GS-LZ-YZ-BAS-1.MAN.NE40-X16%22%2C%22client_type%22%3A%22PC%22%2C%22device_name%22%3A%22Win10%22%2C%22client_version%22%3A%2219.04.01%22%7D
     fi
    sleep 1
           clear
           menu
          ;;
    2)
    session=$(cat ./id.log)
    if [ "$debug" = "$zero" ];then
    qu="`curl http://61.178.5.73/rasPortal/quit.do?req=%7B%22session_id%22%3A%22$session%22%2C%22user_ip%22%3A%22$ipad%22%2C%22quit_type%22%3A%22%E6%AD%A3%E5%B8%B8%E4%B8%8B%E7%BA%BF%22%7D`"
    echo $qu
    else
    curl http://61.178.5.73/rasPortal/quit.do?req=%7B%22session_id%22%3A%22$session%22%2C%22user_ip%22%3A%22$ipad%22%2C%22quit_type%22%3A%22%E6%AD%A3%E5%B8%B8%E4%B8%8B%E7%BA%BF%22%7D
    fi
    rm ./*.log
    sleep 3
          clear
          menu
        ;;
    3)
    echo "输入你的用户名或者是电话号码"
    read username
    curl http://61.178.5.73/rasPortal/antiPorxy.do?req=%7B%22user_name%22%3A%22$username%22%7D
    sleep 5
          clear
          menu
        ;;
    4)
    echo "输入你想修改的IP地址"
    read ipad
    sleep 2
          clear
          menu
       ;; 
    5)
    exit;;

   6)
   debug=1
   sleep 2
   clean 
   menu
    ;;
 7)
   echo $qu
    echo $lo
      echo $ph
   sleep 2
   clean 
   menu
    ;;
esac
}
menu