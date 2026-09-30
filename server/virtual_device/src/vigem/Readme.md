## Compile with
CMD
"C:\Program Files\Microsoft Visual Studio\18\Insiders\Common7\Tools\VsDevCmd.bat" -arch=x64
cl /EHsc /MD /LD /Iinclude vigem_bridge.cpp ViGEmClient.lib SetupAPI.lib ucrt.lib /link /OUT:vigem_bridge.dll