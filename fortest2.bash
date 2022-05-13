
chmod +x /Users/derek/Desktop/coding/bash/gitmanager/fortest.bash
(crontab -l 2>/dev/null ;echo "*/1 * * * * //Users/derek/Desktop/coding/bash/gitmanager/fortest.bash") | crontab - 