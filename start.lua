Create_1 = dofile("./File_Libs/serpent.lua")
Create_2 = require("ssl.https")
Create_4 = io.popen("echo $SSH_CLIENT | awk '{ print $1}'"):read('*a')
local Create_3 = dofile("./File_Libs/redis.lua").connect("127.0.0.1", 6379)
local Create_5 = function() 
local Create_6 = function(Token,Sudo)  
local Create_7 = io.open("sudo.lua", 'w')
Create_7:write([[
token = "]]..Token..[["

Sudo = ]]..Sudo..[[  
]])
Create_7:close()
end  
if not Create_3:get(Create_4.."Token_PASTORE") then
print("\27[1;34m»» Send Your Token Bot :\27[m")
local token = io.read()
if token ~= '' then
local url , res = Create_2.request('https://api.telegram.org/bot'..token..'/getMe')
if res ~= 200 then
io.write('\n\27[1;31m»» Sorry The Token is not Correct \n\27[0;39;49m')
else
io.write('\n\27[1;31m»» The Token Is Saved\n\27[0;39;49m')
Create_3:set(Create_4.."Token_PASTORE",token)
end 
else
io.write('\n\27[1;31mThe Tokem was not Saved\n\27[0;39;49m')
end 
os.execute('lua start.lua')
end
if not Create_3:get(Create_4.."Id_PASTORE") then
print("\27[1;34m\n»» Send Your id Sudo : \27[m")
local Id = io.read():gsub(' ','') 
if tostring(Id):match('%d+') then
io.write('\n\27[1;31m»» The id Is Saved\n\27[0;39;49m')
Create_3:set(Create_4.."Id_PASTORE",Id)
io.write('\n\27[1;31m»» Sorry The id is not Correct \n\27[0;39;49m')
os.execute('lua start.lua')
end
end
local function Files_PASTORE_Info()
Create_6(Create_3:get(Create_4.."Token_PASTORE"),Create_3:get(Create_4.."Id_PASTORE"))   
local RunPASTORE = io.open("PASTORE", 'w')
RunPASTORE:write([[
#!/usr/bin/env bash
cd $HOME/PASTORE
token="]]..Create_3:get(Create_4.."Token_PASTORE")..[["
rm -fr PASTORE.lua
wget "https://raw.githubusercontent.com/PASTORETEAM/PASTORE/main/PASTORE.lua"
while(true) do
rm -fr ../.telegram-cli
./tg -s ./PASTORE.lua -p PROFILE --bot=$token
done
]])
RunPASTORE:close()
local RunTs = io.open("Run", 'w')
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
Create_3:del(Create_4.."Token_PASTORE")
Create_3:del(Create_4.."Id_PASTORE")
sudos = dofile('sudo.lua')
os.execute('./install.sh ins')
end 
local function Load_File()  
local f = io.open("./sudo.lua", "r")  
if not f then   
Create_5()  
var = true
else   
f:close()  
Create_3:del(Create_4.."Token_PASTORE")
Create_3:del(Create_4.."Id_PASTORE")
sudos = dofile('sudo.lua')
os.execute('./install.sh ins')
var = false
end  
return var
end
Load_File()
