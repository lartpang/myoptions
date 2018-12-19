:: Aria2 更新 Trackers
@echo off

::此 Bat 需要放置在 aria2 的所在文件夹下
::本 Bat 需要使用 sed，sed需放置在aria2所在文件夹下。
::sed 可以在 “https://sourceforge.net/projects/gnuwin32/files/sed/4.2.1/sed-4.2.1-bin.zip/download” 下载

::设置当前的aria2配置文件的名称，如配置在子文件夹下，请自行修改。
set conf=aria2n.conf

::设置选择的 trackerlist （可选 trackers_all.txt trackers_best.txt trackers_all_ip.txt trackers_best_ip.txt）
set trackerfile=trackers_all.txt
set downloadfile=https://raw.githubusercontent.com/ngosang/trackerslist/master/%trackerfile%

:: 删除可能之前存在的残留文件
del %temp%\tracker*.*
del %temp%\aria*.*

::下载 trackerlist
aria2c.exe –dir=%temp% “%downloadfile%”

::用 sed 整理 trackerlist 格式
sed.exe “:a;N;s/\n/ /; ta;” %temp%\%trackerfile% > %temp%\trackerstemp.txt
sed.exe “1s/^/bt-tracker=/g; s/ /,/g; s/ $//;” %temp%\trackerstemp.txt > %temp%\trackers.txt

::删除当前 aria2 配置 中的 trackerlist
sed.exe “/^bt-tracker=/d” %conf% > %temp%\aria2n.conf

::合并 trackerlist 和 aria2 配置
copy %temp%\aria2n.conf + %temp%\trackers.txt %temp%\aria2bt.txt
sed.exe “$d” %temp%\aria2bt.txt > %conf%

:: 删除残留的临时文件
del %temp%\tracker*.*
del %temp%\aria*.*
exit
